class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.timestamps
    end
    add_reference :purchases, :user, foreign_key: true, null: false
    add_reference :purchases, :product, foreign_key: true, null: false
  end
end
