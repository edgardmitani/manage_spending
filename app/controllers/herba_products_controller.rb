class HerbaProductsController < ApplicationController
	before_action :authenticate_user!
  
  def index
    if params[:category_id].present?
      @products = HerbaProduct.where(herba_category_id: params[:category_id]).order(:name)
    else
      @products = HerbaProduct.includes(:herba_category).all.order(:name)
    end
    session[:client_id] = params[:client_id] if params[:client_id]
    @client = HerbaClient.find(session[:client_id])
  end

  def edit
    @product = HerbaProduct.find(params[:id])
  end

  def new
    @product = HerbaProduct.new
    @categories = HerbaCategory.all.order(:name)
  end

  def show
  end

  def create
    @product = HerbaProduct.new(product_params)

    if @product.save
      redirect_to herba_products_path, notice: t("title.product") + t("flash_message.successfully_created")
    else
      render action: :new
    end
  end

  def update
    @product = HerbaProduct.find(params[:id])

    if @product.update(product_params)
      redirect_to herba_products_path, notice: t("title.product") + t("flash_message.successfully_updated")
    else
      render action: :edit
    end
  end

  def add_item
    product = HerbaProduct.find(params[:id])
    product.add_item(session[:client_id], product)
    redirect_to herba_products_path, notice: t("title.product") + t("flash_message.successfully_added")
  end

  private
  def product_params
    params.require(:herba_product).permit(:herba_category_id, :code, :name, :price, :portion)
  end
end
