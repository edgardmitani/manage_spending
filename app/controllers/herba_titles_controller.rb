class HerbaTitlesController < ApplicationController
  before_action :authenticate_user!
  
	def index
  	@titles = HerbaTitle.all
  end

  def edit
  	@title = HerbaTitle.find(params[:id])
  end

  def new
  	@title = HerbaTitle.new
  end

  def create
  	@title = HerbaTitle.new(title_params)

  	if @title.save
  		redirect_to herba_titles_path, notice: t("title.title") + t("flash_message.successfully_created")
  	else
  		render action: :new
  	end
  end

  def update
  	@title = HerbaTitle.find(params[:id])

  	if @title.update(title_params)
  		redirect_to herba_titles_path, notice: t("title.title") + t("flash_message.successfully_updated")
  	else
  		render action: :edit
  	end
  end

  def destroy
    @title = HerbaTitle.find(params[:id])
    @title.destroy
    redirect_to herba_titles_path, notice: t("title.title") + t("flash_message.successfully_deleted")
  end

  private
  def title_params
  	params.require(:herba_title).permit(:name, :discount)
  end
end
