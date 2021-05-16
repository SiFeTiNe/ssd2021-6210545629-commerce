class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_detail
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
