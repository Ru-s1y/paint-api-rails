class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :name, null: false, default: "NewPicture"
      t.string :description
      t.string :image, null: false
      t.boolean :publish, dafault: false
      t.integer :user_id, null: false
      t.integer :album_id

      t.timestamps
    end
  end
end
