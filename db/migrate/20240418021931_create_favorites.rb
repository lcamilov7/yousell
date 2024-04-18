class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :favorites, %i[user_id product_id], unique: true # Esto evitará que haya dos favorites de un usuario a un mismo producto
  end
end
