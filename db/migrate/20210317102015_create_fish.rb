class CreateFish < ActiveRecord::Migration[6.1]
  def change
    create_table :fish do |t|
      t.text :title
      t.text :description
      t.integer :stock
      t.integer :price
      t.timestamps
    end
  end
end
