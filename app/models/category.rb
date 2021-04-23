class Category < ApplicationRecord
    has_many :fish_category
    has_many :fish, through: :fish_category
end
