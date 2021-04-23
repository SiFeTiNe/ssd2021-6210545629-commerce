class CreateItem < ActiveRecord::Migration[6.1]
  def change
    create_table :item do |t|
      t.text :title
      t.text :description
      t.integer :stock
      t.integer :price
      t.timestamps
    end
  end
end
