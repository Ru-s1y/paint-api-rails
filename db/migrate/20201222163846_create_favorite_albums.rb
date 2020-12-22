class CreateFavoriteAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_albums do |t|
      t.references :user, foreign_key: true, null: false
      t.references :album, foreign_key: true, null: false

      t.timestamps
    end
  end
end
