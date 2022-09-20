class Order < ApplicationRecord

  belongs_to  :customer
  has_many    :order_items,  dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1}
  
  enum order_status: { before_payment: 0, payment_confirmation: 1, at_work: 2, shipping_preparation: 3, after_shipping: 4 }

end
