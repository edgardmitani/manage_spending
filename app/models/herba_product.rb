class HerbaProduct < ActiveRecord::Base
	validates_presence_of :herba_category_id, :code, :name, :price, :portion
	validates_uniqueness_of :code

	has_many :herba_items
	belongs_to :herba_category

	def add_item(client_id, product)
		profit = product.price * (HerbaClient.first.title.discount/100)
    HerbaItem.create(herba_client_id: client_id, herba_product_id: product.id, price: product.price, profit: profit)
	end
end
