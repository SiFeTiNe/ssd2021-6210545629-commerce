class HomesController < ApplicationController
    def index
        @fish = Fish.all
        @fish = @fish.page(params[:page]).per(5)
    end
    
    def show
        @fish = Fish.find(params[:id])
    end

end