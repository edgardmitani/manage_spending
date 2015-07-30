class HerbaCategoriesController < ApplicationController
	before_action :authenticate_user!
	
  def index
    @categories = HerbaCategory.all.order(:name)
  end

  def edit
  	@category = HerbaCategory.find(params[:id])
  end

  def new
  	@category = HerbaCategory.new
  end

  def create
  	@category = HerbaCategory.new(category_params)

  	if @category.save
  		redirect_to herba_categories_path, notice: t("title.category") + t("flash_message.successfully_created")
  	else
  		render action: :new
  	end
  end

  def update
  	@category = HerbaCategory.find(params[:id])

  	if @category.update(category_params)
  		redirect_to herba_categories_path, notice: t("title.category") + t("flash_message.successfully_updated")
  	else
  		render action: :edit
  	end
  end

  def destroy
    @category = HerbaCategory.find(params[:id])
    @category.destroy

    redirect_to herba_categories_path, notice: t("title.category") + t("flash_message.successfully_deleted")
  end

  private
  def category_params
  	params.require(:herba_category).permit(:name)
  end
end
