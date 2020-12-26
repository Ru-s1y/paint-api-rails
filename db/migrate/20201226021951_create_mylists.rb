class CreateMylists < ActiveRecord::Migration[5.2]
  def change
    create_table :mylists do |t|
      t.references :album, foreign_key: true, null: false
      t.references :picture, foreign_key: true, null: false

      t.timestamps
    end
    add_index :mylists, [:album_id, :picture_id], unique: true
  end
end
