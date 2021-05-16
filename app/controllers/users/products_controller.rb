class Users::ProductsController < ApplicationController

  before_action :authenticate_user!, only: [:create,:edit,:destroy,:csv_upload]

  # GET /products or /products.json
  def index
    @search = params[:search]

    @products = Product.all
    @categories = Category.all
    if @search.present?
      @products = @products.search(@search)
    end
    @products = @products.page(params[:page])
    
    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(Product.all), file_name: 'products.csv' }
    end
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to action: :index, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to action: :index
  end

  def csv_upload
    data = params[:csv_file].read.split("\n")
    data.each do |line|
      attr = line.split(",").map(&:strip)
      Product.create product_name: attr[0], product_detail: attr[1], quantity: attr[2], price: attr[3]
    end
    redirect_to action: :index
  end

  def delete_image
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_to action: :index
  end

  private

    def generate_csv(products)
      products.map { |a| [a.product_name, a.product_detail, a.quantity, a.price, a.created_at.to_date].join(',') }.join("\n")
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:product_name, :product_detail, :price, :quantity, :primary_image,:supported_images => [], :status => []).tap do |w|
        w[:status] = w[:status][1].to_i
      end
    end
end
