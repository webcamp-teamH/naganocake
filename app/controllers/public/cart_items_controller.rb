class Public::CartItemsController < ApplicationController
  def index
    @customer = current_customer
    @cart_items = @customer.cart_items
    @cart_item = CartItem.new

    @cart_count = 0
    @cart_items.each do |cart_item|
      @cart_count += 1
    end

    @cart_total = cart_total
  end

  def cart_total
    cart_total = 0
    current_customer.cart_items.each do |cart_item|
      cart_total += cart_item.subtotal
    end
    return cart_total
  end

  def create
    if @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      if @cart_item.present?
        @cart_item.quantity += params[:cart_item][:quantity].to_i
        @cart_item.save
        redirect_to cart_item_path
      else
        @new_cart_item.customer_id = current_customer.id
        if @new_cart_item.save
          redirect_to cart_item_path
        else
          redirect_to request.referer
        end
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_item_path, notice: "変更しました"
    else
      render :index, notice: "商品数の変更ができませんでした"
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = CartItem.all
    @cart_items.destroy_all
    render :index
  end


  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end

end
