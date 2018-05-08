class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.integer :status_cd
      t.timestamps
    end
  end
end
