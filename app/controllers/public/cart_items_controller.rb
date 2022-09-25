class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    @cart_items = @customer.carts
    @cart_item = Cart.new

    @cart_count = 0
    @cart_items.each do |cart_item|
      @cart_count += 1
    end

    @cart_total = cart_total
  end

  def cart_total
    cart_total = 0
    @customer.carts.each do |cart_item|
      cart_total += cart_item.subtotal
    end
    return cart_total
  end

  def create
    @cart_item_new = Cart.new(cart_item_params)
    @cart_item = current_customer.carts.find_by(item_id: params[:cart][:item_id])
    if Cart.find_by(item_id: params[:cart][:item_id])
      @cart_item.quantity += params[:cart][:quantity].to_i
      @cart_item.save
      redirect_to cart_items_path
    else
      @cart_item_new.customer_id = current_customer.id
      if @cart_item_new.save
        redirect_to cart_items_path
      else
        redirect_to request.referer
      end
    end
  end

  def update
    @cart_item = Cart.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "変更しました"
    else
      render :index, notice: "商品数の変更ができませんでした"
    end
  end

  def destroy
    @cart_item = Cart.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.carts
    @cart_items.destroy_all
    redirect_to cart_items_path
  end


  private
  def cart_item_params
    params.require(:cart).permit(:item_id, :quantity)
  end

end
