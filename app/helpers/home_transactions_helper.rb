module HomeTransactionsHelper
	def get_home_categories
		HomeCategory.all.order(:name)
	end

	def get_home_clients
		HomeClient.all.order(:name)
	end
end
