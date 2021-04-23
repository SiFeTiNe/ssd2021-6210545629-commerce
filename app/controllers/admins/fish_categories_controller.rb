class Admins::FishCategoriesController < ApplicationController
    before_action :authenticate_admin!
    def create
        @categories = Category.find params[:category_id]
        fish = Fish.find_by(description: fish_category_params[:result])
        @categories.fish_category.create(fish: fish)
        # print("This is params ")
        # print("\n")
        # print(fish_category_params)
        redirect_to admins_categories_path
    end
    
    private
    
    def fish_category_params
        params.require(:fish_category).permit(:result)
    end
end