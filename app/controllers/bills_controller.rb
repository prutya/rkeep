class BillsController < ApplicationController
  def index
    authorize! :index, Bill
    @bills = Bill.for_shift
  end

  def new
    authorize! :create, Bill
    @bill = Bill.new
    @tables = Table.select('name, id')
  end

  def create
    authorize! :create, Bill
    Bill.create params_create

    redirect_to bills_url
  end

  def show
    authorize! :show, Bill
    @bill = Bill.find(params[:id])
  end

  def edit
    authorize! :update, Bill
    @bill = Bill.find(params[:id])
    @tables = Table.select('name, id')
  end

  def update
    authorize! :update, Bill
    @bill = Bill.find(params[:id])

    @bill.update_attributes(params_update)

    redirect_to bill_url(@bill)
  end

  def destroy
    authorize! :destroy, Bill
    @bill = Bill.find(params[:id])

    unless @bill.closed?
      @bill.close
      @bill.save!
    end

    redirect_to bills_url
  end

  protected

  def params_create
    params.require(:bill).permit(:table_id, :people_number, :discount)
  end

  def params_update
    params.require(:bill).permit(:table_id, :people_number, :discount)
  end
end
