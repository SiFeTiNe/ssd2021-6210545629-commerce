class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :address
      t.string :postal_code
      t.datetime :order_date

      t.timestamps
    end
  end
end
