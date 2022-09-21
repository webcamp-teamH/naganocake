class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order.shipping_cost = 800
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_status: params[:order][:order_status])
    @order_items = @order.order_items
      if  params[:order][:order_status] == "payment_confirmation"
          @order_items.update(production_status: "waiting_for_production")
      end
      redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end  
  
end
