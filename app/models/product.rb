class Product < ApplicationRecord
    enum status: { draft: 0, published: 1, archived: 2 }
    validates_numericality_of :quantity, :only_interger => true, :greater_than_or_equal_to => 0
    validates_numericality_of :price, :only_decimal => true, :greater_than_or_equal_to => 1.0
    has_many :product_category, dependent: :destroy
    has_many :category, through: :product_category
    has_many :orders, dependent: :destroy
    has_one_attached :primary_image
    has_many_attached :supported_images

    def self.search(search)
        # Title is for the above case, the OP incorrectly had 'name'
        where("product_name LIKE ?", "%#{search}%")
    end
end
