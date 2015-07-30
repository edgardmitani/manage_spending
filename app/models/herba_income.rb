class HerbaIncome < ActiveRecord::Base
	scope :credits, -> { where(mode: "credit") }
	scope :debits, -> { where(mode: "debit") }
	scope :by_month, ->(date) { where(:created_at => date.beginning_of_month..date.end_of_month) }

	belongs_to :herba_client

	def balance
		HerbaIncome.credits.sum(:value) - HerbaIncome.debits.sum(:value)
	end

	def balance_by_month(date)
		HerbaIncome.by_month(date).credits.sum(:value) - HerbaIncome.by_month(date).debits.sum(:value)
	end
end
