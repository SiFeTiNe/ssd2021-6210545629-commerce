class FishCategory < ApplicationRecord
  belongs_to :fish
  belongs_to :category
end
