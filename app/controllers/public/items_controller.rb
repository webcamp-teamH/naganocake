class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @item = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = Cart.new
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end
end
