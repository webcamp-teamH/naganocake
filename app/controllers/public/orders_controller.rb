class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    @order.postcode = @customer.postcode
    @order.address = @customer.address
    @order.name = @customer.first_name + @customer.last_name

    @cart_total = cart_total
    @shipping_cost = shipping_cost
    @grand_total = @cart_total + @shipping_cost

    if params[:order][:select_address] == "ご自身の住所"
      @customer = current_customer
      @selected_address = Address.create(customer_id: @customer, name: @customer.last_name + @customer.first_name, address: @customer.address, postcode: @customer.postcode)

    elsif params[:order][:select_address]  == "登録住所から選択"
      if params[:order][:address_id] == nil
        flash[:registered] = "登録済み住所がありません"
        flash[:new] = ""
        @order = Order.new
        render :new
      else
        @selected_address = Address.find(params[:order][:address_id])
      end

    elsif params[:order][:select_address] == "新しいお届け先"
      if params[:order][:new_name] == "" || order_params[:new_address] == "" || order_params[:new_postcode] == ""
        flash[:new] = "新しいお届け先を入力してください"
        flash[:registered] = ""
        @order = Order.new
        render :new
      else
        @selected_address = Address.create(customer_id: @customer, name: params[:order][:new_name], address: params[:order][:new_address], postcode: params[:order][:new_postcode])
      end
    end
  end

  def finish
  end

  def create
    @order = Order.new(order_params)
    @order.grand_total = cart_total + shipping_cost
    @order.customer_id = current_customer.id
    @order.shipping_cost = shipping_cost
    @order.save
    @cart_items = current_customer.carts
    @cart_items.each do |cart_item|
      @order_detail = OrderItem.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.tax_price = cart_item.item.with_tax_price
      @order_detail.quantity = cart_item.quantity
      @order_detail.save
    end
    current_customer.carts.destroy_all
    redirect_to orders_finish_path
  end

  def index
    @customer = current_customer
    @orders = @customer.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_items
  end

  def cart_total
    cart_total = 0
    current_customer.carts.each do |cart_item|
      cart_total += cart_item.subtotal
    end
    return cart_total
  end

  def shipping_cost
    shipping_cost = 800
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :address_id, :postcode, :address, :name)
  end
end
