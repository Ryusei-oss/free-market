class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name ,null: false
      t.integer :price ,null: false
      t.text :explanation ,null: false
      t.integer :size_id ,null: false
      t.string :quality_id ,null: false
      t.string :shipping_charge_id ,null: false
      t.string :delivery_date_id ,null: false
      t.string :trading_status ,null: false
      t.integer :area_id ,null: false
      # t.references :user , foreign_key: true
      # t.references :category , foreign_key: true
      # t.references :brand , foreign_key: true
      t.timestamps
    end
  end
end