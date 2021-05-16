class Users::ProductCategoriesController < ApplicationController
    def create
        @categories = Category.find(params[:category_id])
        product = Product.find_by(product_detail: product_category_params[:result])
        @categories.product_category.create(product: product)

        redirect_to categories_path
    end

    private

    def product_category_params
        params.require(:product_category).permit(:result)
    end
end
