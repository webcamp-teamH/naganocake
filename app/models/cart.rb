class Cart < ApplicationRecord

  belongs_to :customer
  belongs_to :item
  
  #小計のメソッド
  def subtotal
    item.with_tax_price * quantity
  end

end
