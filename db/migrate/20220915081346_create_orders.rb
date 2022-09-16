class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id,   null: false
      t.string :postcode,       null: false
      t.string :adress,         null: false
      t.string :name,           null: false
      t.integer :payment_method,null: false,  default: 0
      t.integer :order_status,  null: false,  default: 0
      t.integer :shipping_cost, null: false
      t.integer :grand_total,   null: false

      t.timestamps
    end
  end
end
