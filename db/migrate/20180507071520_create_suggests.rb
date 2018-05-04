class CreateSuggests < ActiveRecord::Migration[5.1]
  def change
    create_table :suggests do |t|
      t.belongs_to :user
      t.text :content
      t.attachment :image
      t.integer :status_cd
      t.timestamps
    end
  end
end
