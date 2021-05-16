class Users::CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @categories = Category.find(params[:id])
  end

  def new
    @categories = Category.new
  end

  def edit
    @categories = Category.find(params[:id])
  end

  def create
    @categories = Category.create(category_params)

    if @categories.invalid?
      flash[:error] = @categories.error.full_messages
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
    params.require(:category).permit(:category_name, :category_description)
  end

end
