class HomesController < ApplicationController
    def index
        @search = params[:search]

        @products = Product.all
        @categories = Category.all
        if @search.present?
            @products = @products.search(@search)
        end
        @products = @products.page(params[:page])
      end

    def show
        @products = Product.find(params[:id])
    end

    def create_order
        @products = Product.find(params[:home_id])
        if request.post?
            customer_name = params['customer_name']
            address = params['address']
            postal_code = params['postal_code']
            now = Time.now
            @order = @products.orders.create(product_id: @product, customer_name: customer_name, address: address, postal_code: postal_code, order_date: now)

            redirect_to '/'
        end
    end
end
