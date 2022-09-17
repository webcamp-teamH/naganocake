class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order.shipping_cost = 800
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private

  def order_params
    params.require(:order).permit( :status)
  end  
  
end
