class HomeTransactionsController < ApplicationController
  before_action :authenticate_user!
  
	def index
    if params[:home_category_id].present?
      @transactions = HomeTransaction.includes(:home_category).where("home_category_id = ? and created_at <= ?", params[:home_category_id], Time.now.end_of_day).page(params[:page]).order(created_at: :desc)
    elsif params[:home_client_id].present?
      @transactions = HomeTransaction.includes(:home_category).where("created_at <= ? and home_client_id = ?", Time.now.end_of_day, 2).page(params[:page]).order(created_at: :desc)
    else
		  @transactions = HomeTransaction.includes(:home_category).where("created_at <= ? and home_client_id = ?", Time.now.end_of_day, 1).page(params[:page]).order(created_at: :desc)
    end
    @future_transactions = HomeTransaction.includes(:home_category).where("created_at > ? and created_at <= ? and home_client_id = ?", Time.now.end_of_day, Time.now.end_of_day + 1.month, 1).page(params[:page]).order(created_at: :desc)
	end

  def edit
    @transaction = HomeTransaction.find(params[:id])
  end

  def new
  	@transaction = HomeTransaction.new
  end

  def create
  	@transaction = HomeTransaction.new(transaction_params)

  	if @transaction.save
  		redirect_to new_home_transaction_path, notice: t("title.transaction") + t("flash_message.successfully_created")
  	else
  		render action: :new
  	end
  end

  def update
    @transaction = HomeTransaction.find(params[:id])

    if @transaction.update(transaction_params)
      redirect_to home_transactions_path, notice: t("title.transaction") + t("flash_message.successfully_updated")
    else
      render action: :edit
    end
  end

  def destroy
    @transaction = HomeTransaction.find(params[:id])
    @transaction.destroy
    redirect_to home_transactions_path, notice: t("title.transaction") + t("flash_message.successfully_deleted")
  end

  def new_credit_card
    @transaction = HomeTransaction.new
  end

  def create_credit_card
    parcel = params[:parcel].to_i
    value = params[:home_transaction][:value].to_f/parcel

    parcel.times do |i|
      transaction = HomeTransaction.new
      transaction.value = value
      transaction.home_client_id = params[:home_transaction][:home_client_id]
      transaction.home_category_id = params[:home_transaction][:home_category_id]
      transaction.mode = "debit"
      transaction.description = "#{i+1}/#{parcel} #{params[:home_transaction][:description]}"
      transaction.created_at = (Date.today.beginning_of_month + 9.days) + (i + 1).month
      transaction.save
    end
    redirect_to new_credit_card_home_transactions_path, notice: t("title.transaction") + t("flash_message.successfully_created")
  end

  def new_transfer
    @transaction = HomeTransaction.new
  end

  def create_transfer
    transaction = HomeTransaction.new
    transaction.value = params[:home_transaction][:value]
    transaction.home_client_id = params[:from_client_id]
    transaction.home_category_id = 10
    transaction.mode = "debit"
    transaction.description = "Transferência"
    transaction.save

    transaction = HomeTransaction.new
    transaction.value = params[:home_transaction][:value]
    transaction.home_client_id = params[:to_client_id]
    transaction.home_category_id = 11
    transaction.mode = "credit"
    transaction.description = "Akio"
    transaction.save
    redirect_to home_transactions_path, notice: t("title.transaction") + t("flash_message.successfully_created")
  end

  private
  def transaction_params
  	params.require(:home_transaction).permit(:home_client_id, :home_category_id, :value, :profit, :mode, :description)
  end
end
