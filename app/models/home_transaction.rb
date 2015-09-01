class HomeTransaction < ActiveRecord::Base
	validates_presence_of :mode, :value

	scope :credits, -> { where("mode = ? and home_client_id = ?", "credit", 1) }
	scope :debits, -> { where("mode = ? and home_client_id = ?", "debit", 1) }
	scope :my_credits, -> { where("mode = ? and home_client_id = ?", "credit", 2) }
	scope :my_debits, -> { where("mode = ? and home_client_id = ?", "debit", 2) }
	scope :by_month, -> (date) { where(:created_at => date.beginning_of_month..date.end_of_month) }
	scope :by_until_today, -> (date) { where("created_at <= ?", date) }

	scope :food,    -> { where("home_category_id = ?", 1) }
	scope :fuel, 	  -> { where("home_category_id = ?", 2) }
	scope :water,   -> { where("home_category_id = ?", 3) }
	scope :light,   -> { where("home_category_id = ?", 4) }
	scope :phone,   -> { where("home_category_id = ?", 5) }
	scope :unimed,  -> { where("home_category_id = ?", 6) }
	scope :murilo,  -> { where("home_category_id = ?", 7) }
	scope :others,  -> { where("home_category_id = ?", 8) }
	scope :car, 	  -> { where("home_category_id = ?", 9) }
	scope :home,    -> { where("home_category_id = ?", 10) }
	scope :expense, -> { where("home_category_id <> ?", 11) }
	
	belongs_to :home_category

	#SALDO LIQUIDO
	def balance
		HomeTransaction.credits.by_until_today(Time.now.end_of_day).sum(:value) - HomeTransaction.debits.by_until_today(Time.now.end_of_day).sum(:value)
	end

	def my_balance
		HomeTransaction.my_credits.sum(:value) - HomeTransaction.my_debits.sum(:value)
	end

	#DESPESA NO MES
	def expense_current_month
		HomeTransaction.debits.expense.by_month(Time.now).sum(:value)
	end

	#DESPESA COMIDA
	def records_food
		array = []
		4.times do |i|
			array << HomeTransaction.debits.food.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA AGUA
	def records_water
		array = []
		4.times do |i|
			array << HomeTransaction.debits.water.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA LUZ
	def records_light
		array = []
		4.times do |i|
			array << HomeTransaction.debits.light.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA TELEFONE
	def records_phone
		array = []
		4.times do |i|
			array << HomeTransaction.debits.phone.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA UNIMED
	def records_unimed
		array = []
		4.times do |i|
			array << HomeTransaction.debits.unimed.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA COMBUSTIVEL
	def records_fuel
		array = []
		4.times do |i|
			array << HomeTransaction.debits.fuel.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA MURILO
	def records_murilo
		array = []
		4.times do |i|
			array << HomeTransaction.debits.murilo.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA OUTROS
	def records_others
		array = []
		4.times do |i|
			array << HomeTransaction.debits.others.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA CARRO
	def records_car
		array = []
		4.times do |i|
			array << HomeTransaction.debits.car.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA CASA
	def records_home
		array = []
		4.times do |i|
			array << HomeTransaction.debits.home.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	#DESPESA
	def records_expense
		array = []
		4.times do |i|
			array << HomeTransaction.debits.expense.by_month(Time.now - (i).months).sum(:value)
	end
	array.reverse
	end

	def translate_mode
		case self.mode
		when "credit"
			"Crédito"
		when "debit"
			"Débito"
		when "income"
			"Renda"
		when "repayment"
			"Reembolsado"
		end
	end
end
