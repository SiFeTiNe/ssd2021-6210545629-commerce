class Admins::ItemCategoriesController < ApplicationController
    before_action :authenticate_admin!
    def create
        @categories = Category.find params[:category_id]
        item = Item.find_by(description: item_category_params[:result])
        @categories.item_category.create(item: item)
        # print("This is params ")
        # print("\n")
        # print(item_category_params)
        redirect_to admins_categories_path
    end
    
    private
    
    def item_category_params
        params.require(:item_category).permit(:result)
    end
end