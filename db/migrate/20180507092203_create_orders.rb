class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.integer :status
      t.timestamps
    end
  end
end
