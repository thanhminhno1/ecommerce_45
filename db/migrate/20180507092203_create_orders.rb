class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.integer :status
      t.string :name
      t.string :phone_number
      t.string :address
      t.timestamps
    end
  end
end
