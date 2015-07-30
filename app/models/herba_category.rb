class HerbaCategory < ActiveRecord::Base
	validates_presence_of :name

	has_many :herba_products
end
