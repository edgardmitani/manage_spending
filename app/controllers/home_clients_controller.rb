class HomeClientsController < ApplicationController
	before_action :authenticate_user!
	
  def index
    @clients = HomeClient.all.order(:name)
  end

  def edit
  	@client = HomeClient.find(params[:id])
  end

  def new
  	@client = HomeClient.new
  end

  def create
  	@client = HomeClient.new(client_params)

  	if @client.save
  		redirect_to home_clients_path, notice: t("title.client") + t("flash_message.successfully_created")
  	else
  		render action: :new
  	end
  end

  def update
  	@client = HomeClient.find(params[:id])

  	if @client.update(client_params)
  		redirect_to home_clients_path, notice: t("title.client") + t("flash_message.successfully_updated")
  	else
  		render action: :edit
  	end
  end

  def destroy
    @client = HomeClient.find(params[:id])
    @client.destroy

    redirect_to home_clients_path, notice: t("title.client") + t("flash_message.successfully_deleted")
  end

  private
  def client_params
  	params.require(:home_client).permit(:name)
  end
end
