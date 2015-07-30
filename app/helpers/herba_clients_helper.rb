module HerbaClientsHelper
	def get_herba_titles
		HerbaTitle.all
	end

	def pending_item?(client)
		client.herba_items.not_payment.count > 0 ? true : false
	end
end
