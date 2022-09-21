class OrderItem < ApplicationRecord
  
  belongs_to :item
  belongs_to :order
  
  enum production_status: { before_production: 0, waiting_for_production: 1, in_production: 2, end_production: 3 }
  
  def in_tax_price
    ( tax_price * 1.1 ).floor
  end
  
  def sub_total
    in_tax_price * quantity
  end  
 
end
