class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.belongs_to :user
      t.string :products
      t.timestamps
    end
  end
end
