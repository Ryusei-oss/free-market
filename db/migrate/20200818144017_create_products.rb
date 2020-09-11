class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name ,null: false
      t.integer :price ,null: false
      t.text :explanation ,null: false
      t.integer :quality_id ,null: false
      t.integer :shipping_charge_id ,null: false
      t.integer :delivery_date_id ,null: false
      t.string :trading_status ,null: false, default:"出品中"
      t.integer :area_id ,null: false
      t.timestamps
    end
  end
end