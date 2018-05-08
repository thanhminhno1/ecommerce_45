class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :password
      t.string :name
      t.string :address
      t.string :phone_number
      t.integer :role_cd, default: 1
      t.timestamps
    end
  end
end
