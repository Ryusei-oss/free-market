class AddReferencesToImage < ActiveRecord::Migration[5.2]
  def change
    add_reference :images, :product, foreign_key: true
  end
end
