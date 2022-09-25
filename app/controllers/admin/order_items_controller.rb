class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  def update
   @order_item = OrderItem.find(params[:id])
   @order = @order_item.order
   @order_items = @order.order_items
   @order_item.update(order_item_params)
    if params[:order_item][:production_status] == "in_production"
       @order.update(order_status: "at_work")
    end
    if @order_items.count == @order_items.where(production_status: "end_production").count
       @order.update(order_status: "shipping_preparation")
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

end

