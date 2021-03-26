class TestProductsController < ApplicationController
  def index
    @search = params[:search]
    @products = Product.all
    if @search.present?
      @products = @products.where('title LIKE ? or description LIKE ?', "%#{@search}", "%#{@search}").page(@search).per(5)
    end
    @products = @products.page(params[:page]).per(10)
  end
end
