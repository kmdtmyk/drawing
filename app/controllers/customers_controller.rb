# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all.order(:display_order)
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.created_by(current_user)
    if @customer.save
      redirect_to customers_url, notice: '顧客の作成に成功しました'
    else
      render :new
    end
  end

  def update
    @customer.updated_by(current_user)
    if @customer.update(customer_params)
      redirect_to customers_url, notice: '顧客の更新に成功しました'
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_url, notice: '顧客の削除に成功しました'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :short_name, :display_order, :order_flag, :outsource_flag)
    end
end
