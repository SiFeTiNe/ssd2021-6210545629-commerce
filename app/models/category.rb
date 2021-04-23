class Category < ApplicationRecord
    has_many :item_category
    has_many :item, through: :item_category
end
