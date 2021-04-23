class CreateFishCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :fish_categories do |t|
      t.references :fish, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
