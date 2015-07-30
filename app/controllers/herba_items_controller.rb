class HerbaItemsController < ApplicationController
	before_action :authenticate_user!
	
  def show
  	@client = HerbaClient.includes(:herba_items).find(params[:id])
    session[:client_id] = params[:id]
  end

  def edit
    @item = HerbaItem.find(params[:id])
  end

  def update
    @item = HerbaItem.find(params[:id])

    if @item.update(item_params)
      redirect_to herba_item_path(@item.client), notice: t("title.item") + t("flash_message.successfully_updated")
    else
      render action: :edit
    end
  end

  def confirm_delivery
  	item = HerbaItem.find(params[:id])
    item.confirm_delivery!
  	redirect_to herba_item_path(session[:client_id])
  end

  private
  def item_params
    params.require(:herba_item).permit(:price, :profit)
  end
end
