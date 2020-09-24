class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.timestamps
    end
    add_reference :likes, :user, foreign_key: true, null: false
    add_reference :likes, :product, foreign_key: true, null: false
  end
end
