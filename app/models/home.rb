class Home
	def herba_active_clients_quantity
		HerbaItem.where("date(product_date) >= ?", Date.today).group(:herba_client_id).count
	end

	def herba_outstanding_products_quantity
		HerbaItem.not_payment.count
	end

	def herba_payed_products_quantity
		HerbaItem.payment.count
	end
end
