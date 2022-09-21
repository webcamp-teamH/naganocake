class Order < ApplicationRecord

  belongs_to  :customer
  has_many    :order_items,  dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1}

  enum order_status: { before_payment: 0, payment_confirmation: 1, at_work: 2, shipping_preparation: 3, after_shipping: 4 }

  def all_sub_total
    total = 0
    order_items.each do |order_item|
    total += order_item.in_tax_price * order_item.quantity
    end
    total
  end
 
  def grand_total
    all_sub_total + shipping_cost
  end
end