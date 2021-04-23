class HomesController < ApplicationController
    def index
        @item = Item.all
        @item = @item.page(params[:page]).per(5)
    end
    
    def show
        @item = Item.find(params[:id])
    end

end