class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name, null: false, default: "NewAlbum"
      t.string :description
      t.boolean :publish, default: "false"
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
