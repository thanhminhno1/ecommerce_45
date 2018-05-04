class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.belongs_to :category
      t.string :name
      t.text :description
      t.attachment :image
      t.integer :price
      t.integer :quantity
      t.float :avg_star, default: 0
      t.timestamps
    end
  end
end
