class CreateFavoritePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_pictures do |t|
      t.references :user, foreign_key: true, null: false
      t.references :picture, foreign_key: true, null: false

      t.timestamps
    end
  end
end
