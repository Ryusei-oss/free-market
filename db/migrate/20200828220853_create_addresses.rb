class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true
      t.integer :postal_code ,null: false
      t.string :area ,null: false
      t.string :city ,null: false
      t.integer :house_number ,null: false
      t.string :building
      t.timestamps
    end
  end
end
