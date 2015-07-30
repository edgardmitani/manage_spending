class HerbaTransaction < ActiveRecord::Base
	validates_presence_of :mode, :value

	scope :credits, -> { where(mode: "credit") }
	scope :debits, -> { where(mode: "debit") }

	belongs_to :herba_client

	after_create :make_payment

	private
	def make_payment
		master_client = HerbaClient.first
		if self.herba_client != master_client && self.mode == "credit" && self.herba_client.herba_items.not_payment
			total_value = self.herba_client.balance
			self.herba_client.herba_items.not_payment.each do |item|
				if item.price <= total_value
					item.payment_date = Time.now
					item.save
					create_debit_transaction(self.herba_client.id, item.price, item.herba_product.name)
					create_credit_transaction(master_client, item.price, "#{self.herba_client.name} - Pagamento do produto #{item.herba_product.name}")
					create_credit_income(self.herba_client_id, item.profit, item.herba_product.name)
					total_value -= item.price
				end
			end
		end
	end

	def create_debit_transaction(client_id, value, product_name)
		HerbaTransaction.create(herba_client_id: client_id, value: value, mode: "debit", description: "Pagamento do produto #{product_name}")
	end

	def create_credit_transaction(master_client, value, description)
		HerbaTransaction.create(herba_client_id: master_client.id, value: value, mode: "credit", description: description)
	end

	def create_credit_income(client_id, value, product_name)
		HerbaIncome.create(herba_client_id: client_id, value: value, mode: "credit", description: "Lucro sobre o produto #{product_name}") if value > 0
	end
end
