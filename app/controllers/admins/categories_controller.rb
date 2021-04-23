class Admins::CategoriesController < ApplicationController
    before_action :authenticate_admin!,only: [:create,:edit,:destroy]
    def index
        @categories = Category.all 
        @categories = @categories.page(params[:page]).per(5)
    end

    def show
        @categories = Category.find(params[:id])
    end

    def new
        puts "This is how you print out something."
        @categories = Category.new
    end
    
    def edit
        @categories = Category.find(params[:id])
    end

    def create
        @categories = Category.create(category_params)
    
        if @categories.invalid?
          flash[:error] = @categories.errors.full_messages
        end
    
        redirect_to action: :index
    end
    
    def update
        @categories = Category.find(params[:id])
        @categories.update(category_params)
        redirect_to action: :index
    end

    def destroy
        @categories = Category.find(params[:id])
        @categories.destroy
        redirect_to action: :index
    end

    private
    def category_params
        params.require(:category).permit(:title, :description)
    end
end