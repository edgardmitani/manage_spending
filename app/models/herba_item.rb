class HerbaItem < ActiveRecord::Base
	belongs_to :herba_client
	belongs_to :herba_product

	scope :not_payment, -> { where("delivery_date is not ? and payment_date is ?", nil, nil) }
	scope :payment, -> { where("delivery_date is not ? and payment_date is not ?", nil, nil) }

	def total_receivables
		HerbaItem.not_payment.sum(:price) - HerbaClient.new.client_credits
	end

	def confirm_delivery!
		self.delivery_date = date = Time.now
  	self.product_date = date + self.herba_product.portion.days
  	self.save
	end
end
