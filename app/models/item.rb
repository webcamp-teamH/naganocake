class Item < ApplicationRecord

  has_one_attached  :image
  belongs_to        :genre
  has_many          :carts,        dependent: :destroy
  has_many          :order_items,  dependent: :destroy

end
