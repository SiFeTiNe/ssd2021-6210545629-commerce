class OrdersController < ApplicationController
    def index
        @orders = Order.all
    end

    def show
        @orders = Order.find(params[:id])
        @product = Product.find(@orders.product_id)
    end

    def new
        @orders = Order.new
    end

    def edit
        @orders = Order.find(params[:id])
    end

    def create
        @orders = Order.create(order_params)
        if @orders.invalid?
            flash[:error] = @orders.errors.full_messages
        end

        redirect_to action: :index
    end

    def update
        @orders = Order.find(params[:id])
        @orders.update(order_params)
    end

    def destroy
        @orders = Order.find(params[:id])
        @orders.destroy
        redirect_to action: :index
    end

    def order_params
        params.require(:order).permit(:customer_name, :address, :postal_code)
    end

end
