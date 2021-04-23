class Admins::FishController < ApplicationController
  before_action :authenticate_admin!,only: [:create,:edit,:destroy,:csv_upload]
  def index
    @fish = Fish.all
    @fish = @fish.page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(Fish.all), file_name: 'fish.csv' }
    end
  end

  def show
    @fish = Fish.find(params[:id])
  end

  def new
    puts "This is how you print out something."
    @fish = Fish.new
  end

  def edit
    @fish = Fish.find(params[:id])
  end

  def create
    @fish = Fish.create(fish_params)
    if @fish.invalid?
      flash[:error] = @fish.errors.full_messages
    end

    redirect_to action: :index
  end

  def update
    @fish = Fish.find(params[:id])
    @fish.update(fish_params)
    print("This is Fish Params")
    print("\n")
    print(fish_params[:primary_image])
    print("\n")
    print(fish_params[:supported_images])
    redirect_to action: :index
  end

  def destroy
    @fish = Fish.find(params[:id])
    @fish.destroy
    redirect_to action: :index
  end

  def csv_upload
    data = params[:csv_file].read.split("\n")
    data.each do |line|
      attr = line.split(",").map(&:strip)
      Fish.create title: attr[0], description: attr[1], stock: attr[2], price: attr[3]
    end
    redirect_to action: :index
  end

  def delete_image
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_to action: :index
  end

  private

  def generate_csv(articles)
    articles.map { |a| [a.title, a.description,a.stock,a.price, a.created_at.to_date].join(',') }.join("\n")
  end

  def fish_params
    params.require(:fish).permit(:title, :description,:stock,:price,:primary_image,:supported_images => [],:status => []).tap do |w|
      w[:status] = w[:status][1].to_i
    end
  end
end
