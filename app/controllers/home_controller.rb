class HomeController < ApplicationController
	before_action :authenticate_user!
	
  def index
    @home = Home.new

    @result = nil
  	incomes = []
    income_object = HerbaIncome.new
  	4.times do |i|
  		incomes << income_object.balance_by_month(Date.today - (i + 1).months)
  	end
  	@incomes = incomes.reverse
    @income_current_month = income_object.balance_by_month(Date.today)
    @total_income = income_object.balance
    @total_receivables = HerbaItem.new.total_receivables
  	@date = Date.today - @incomes.count.months
    @client = HerbaClient.first
    @result = @client.herba_profiles.first.weight - @client.herba_profiles.last.weight if @client && @client.herba_profiles.present?
    session[:client_id] = 1

    transaction = HomeTransaction.new
    @balance = transaction.balance
    @records_food = transaction.records_food
    @records_fuel = transaction.records_fuel
    @records_water = transaction.records_water
    @records_light = transaction.records_light
    @records_phone = transaction.records_phone
    @records_unimed = transaction.records_unimed
    @records_murilo = transaction.records_murilo
    @records_others = transaction.records_others
    @records_car = transaction.records_car
    @records_home = transaction.records_home
    @records_expense = transaction.records_expense
    @my_balance = transaction.my_balance
  end
end
