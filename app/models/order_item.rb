class OrderItem < ApplicationRecord
  
  belongs_to :item
  belongs_to :order
  
  enum production_status: { before_production: 0, waiting_for_production: 1, in_production: 2, end_production: 3 }
  
end
