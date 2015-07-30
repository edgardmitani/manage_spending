class HerbaClientsController < ApplicationController
	before_action :authenticate_user!
	
  def index
    @clients = []
    if params[:client_name]
      @clients = HerbaClient.includes([:herba_title, :herba_items]).where("name like ?", "%#{params[:client_name]}%").order("name asc").page(params[:page])
      flash.now[:alert] = t("flash_message.client_not_found") if @clients.blank?
    else
      @clients = HerbaClient.includes([:herba_title, :herba_items]).order("name asc").page(params[:page])
    end
  end

  def edit
    @client = HerbaClient.find(params[:id])
  end

  def show
    @client = HerbaClient.includes(:herba_address).find(params[:id])
    session[:client_id] = @client.id
  end

  def new
    @client = HerbaClient.new
    @client.build_herba_address
    @client.build_herba_title
  end

  def create
    @client = HerbaClient.new(client_params)

    if @client.save
      redirect_to herba_clients_path, notice: t("title.client") + t("flash_message.successfully_created")
    else
      render action: :new
    end
  end

  def update
    @client = HerbaClient.find(params[:id])

    if @client.update(client_params)
      redirect_to herba_clients_path, notice: t("title.client") + t("flash_message.successfully_updated")
    else
      render action: :edit
    end
  end

  private
  def client_params
    params.require(:herba_client).permit(:herba_title_id, :name, :email, :phone, herba_address_attributes: [:id, :herba_client_id, :zip_code, :street, :number, :neighborhood, :city, :state])
  end
end
