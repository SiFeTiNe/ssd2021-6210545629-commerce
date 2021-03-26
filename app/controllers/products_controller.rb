class ProductsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @search = params[:search]
    @products = Product.all
    if @search.present?
      @products = @products.where('title LIKE ? or description LIKE ?', "%#{@search}", "%#{@search}").page(@search).per(10)
    end
    @products = @products.page(params[:page]).per(10)
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.create(product_params)

    flash[:error] = @product.errors.full_messages if @product.invalid?

    redirect_to action: :index
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to action: :index
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to action: :index
  end

  private

  def product_params
    params.require(:product).permit(:title, :description)
  end
end
