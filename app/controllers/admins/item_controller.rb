class Admins::ItemController < ApplicationController
  before_action :authenticate_admin!,only: [:create,:edit,:destroy,:csv_upload]
  def index
    @item = Item.all
    @item = @item.page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(Item.all), file_name: 'item.csv' }
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    puts "This is how you print out something."
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.create(item_params)
    if @item.invalid?
      flash[:error] = @item.errors.full_messages
    end

    redirect_to action: :index
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    print("This is Item Params")
    print("\n")
    print(item_params[:primary_image])
    print("\n")
    print(item_params[:supported_images])
    redirect_to action: :index
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to action: :index
  end

  def csv_upload
    data = params[:csv_file].read.split("\n")
    data.each do |line|
      attr = line.split(",").map(&:strip)
      Item.create title: attr[0], description: attr[1], stock: attr[2], price: attr[3]
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

  def item_params
    params.require(:item).permit(:title, :description,:stock,:price,:primary_image,:supported_images => [],:status => []).tap do |w|
      w[:status] = w[:status][1].to_i
    end
  end
end
