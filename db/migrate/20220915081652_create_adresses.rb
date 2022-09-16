class CreateAdresses < ActiveRecord::Migration[6.1]
  def change
    create_table :adresses do |t|

      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.string :postcode, null: false

      t.timestamps
    end
  end
end
