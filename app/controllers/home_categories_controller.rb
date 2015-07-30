class HomeCategoriesController < ApplicationController
	before_action :authenticate_user!
	
  def index
    @categories = HomeCategory.all.order(:name)
  end

  def edit
  	@category = HomeCategory.find(params[:id])
  end

  def new
  	@category = HomeCategory.new
  end

  def create
  	@category = HomeCategory.new(category_params)

  	if @category.save
  		redirect_to home_categories_path, notice: t("title.category") + t("flash_message.successfully_created")
  	else
  		render action: :new
  	end
  end

  def update
  	@category = HomeCategory.find(params[:id])

  	if @category.update(category_params)
  		redirect_to home_categories_path, notice: t("title.category") + t("flash_message.successfully_updated")
  	else
  		render action: :edit
  	end
  end

  def destroy
    @category = HomeCategory.find(params[:id])
    @category.destroy

    redirect_to home_categories_path, notice: t("title.category") + t("flash_message.successfully_deleted")
  end

  private
  def category_params
  	params.require(:home_category).permit(:name)
  end
end
