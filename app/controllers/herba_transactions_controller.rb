class HerbaTransactionsController < ApplicationController
  before_action :authenticate_user!
  
	def index
		@transactions = HerbaTransaction.where(herba_client_id: session[:client_id]).page(params[:page]).order(id: :desc)
	end

  def edit
    @transaction = HerbaTransaction.find(params[:id])
  end

  def new
    session[:client_id] = params[:client_id] if params[:client_id]
  	@transaction = HerbaTransaction.new
    @client = HerbaClient.find(session[:client_id])
  end

  def create
  	@transaction = HerbaTransaction.new(transaction_params)

  	if @transaction.save
  		redirect_to herba_transactions_path, notice: t("title.transaction") + t("flash_message.successfully_created")
  	else
  		render action: :new
  	end
  end

  def update
    @transaction = HerbaTransaction.find(params[:id])

    if @transaction.update(transaction_params)
      redirect_to herba_transactions_path, notice: t("title.transaction") + t("flash_message.successfully_updated")
    else
      render action: :edit
    end
  end

  def destroy
    @transaction = HerbaTransaction.find(params[:id])
    @transaction.destroy
    redirect_to herba_transactions_path, notice: t("title.transaction") + t("flash_message.successfully_deleted")
  end

  private
  def transaction_params
  	params.require(:herba_transaction).permit(:herba_client_id, :value, :profit, :mode, :description)
  end
end
