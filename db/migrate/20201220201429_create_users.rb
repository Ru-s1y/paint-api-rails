class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, default: "NewUser"
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :activated,null: false, default: true

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end