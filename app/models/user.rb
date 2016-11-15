class User < ApplicationRecord
  has_many :assignments
  has_many :spendings
  has_many :bills
  has_many :user_shifts
  has_many :shifts, through: :user_shifts
  has_many :roles, through: :assignments

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, allow_blank: false
  validates :last_name,  presence: true, allow_blank: false
  validates :phone,      presence: true, allow_blank: false

  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    role?(:admin)
  end

  def employee?
    role?(:employee)
  end

  protected

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end
end
