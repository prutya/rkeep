class BillItem < ApplicationRecord
  belongs_to :bill
  belongs_to :good

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def calculate_subtotal
    self.quantity * self.good.price
  end

  def calculate_total(discount)
    calculate_subtotal * (100 - discount) / 100
  end
end