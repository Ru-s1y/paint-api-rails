class CreatePictureTags < ActiveRecord::Migration[5.2]
  def change
    create_table :picture_tags do |t|
      t.references :picture, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
