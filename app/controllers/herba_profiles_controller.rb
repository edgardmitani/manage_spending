class HerbaProfilesController < ApplicationController
	before_action :authenticate_user!
	
  def show
  	@client = HerbaClient.includes(:herba_profiles).find(params[:id])
    session[:client_id] = params[:id]
  end

  def edit
    @profile = HerbaProfile.find(params[:id])
    @client = HerbaClient.find(params[:client_id])
  end

  def new
  	@profile = HerbaProfile.new
    @client = HerbaClient.find(params[:client_id])
  end

  def create
  	@profile = HerbaProfile.new(profile_params)
    @client = HerbaClient.find(params[:profile][:client_id])

  	if @profile.save
  		redirect_to herba_profile_path(params[:herba_profile][:client_id]), notice: t("title.profile") + t("flash_message.successfully_created")
  	else
  		render action: :new, client_id: params[:herba_profile][:client_id]
  	end
  end

  def update
  	@profile = HerbaProfile.find(params[:id])

  	if @profile.update(profile_params)
  		redirect_to herba_profile_path(params[:herba_profile][:client_id]), notice: t("title.profile") + t("flash_message.successfully_updated")
  	else
  		render action: :edit, client_id: params[:herba_profile][:client_id]
  	end
  end

  def destroy
    @profile = HerbaProfile.find(params[:id])
    client_id = @profile.herba_client.id
    @profile.destroy

    redirect_to herba_profile_path(client_id), notice: t("title.profile") + t("flash_message.successfully_deleted")
  end

  private
  def profile_params
  	params.require(:herba_profile).permit(:herba_client_id, :weight, :chest, :rib, :belly, :hip)
  end
end
