class HerbaIncomesController < ApplicationController
  before_action :authenticate_user!
  
	def index
  	@incomes = HerbaIncome.all.page(params[:page])
  	@gross_income = HerbaIncome.new.balance
  end

  def edit
  	@income = HerbaIncome.find(params[:id])
  end

  def update
  	@income = HerbaIncome.find(params[:id])

  	if @income.update(income_params)
  		redirect_to herba_incomes_path, notice: t("title.income") + t("flash_message.successfully_updated")
  	else
  		render action: :edit
  	end
  end

  private
  def income_params
  	params.require(:herba_income).permit(:value)
  end
end
