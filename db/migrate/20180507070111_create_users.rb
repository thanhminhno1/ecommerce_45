class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :password_digest
      t.string :name
      t.string :address
      t.string :phone_number
      t.integer :role, default: 1
      t.timestamps
    end
  end
end
