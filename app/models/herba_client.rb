class HerbaClient < ActiveRecord::Base
	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	validates_presence_of :name
	validates_format_of :email, with: EMAIL_REGEXP

	belongs_to :herba_title

	has_one :herba_address
	has_many :herba_items
	has_many :herba_incomes
	has_many :herba_profiles
	has_many :herba_transactions


	accepts_nested_attributes_for :herba_address

	before_create :set_initial_title

	def balance
		self.herba_transactions.credits.sum(:value) - self.herba_transactions.debits.sum(:value)
	end

	def payment_balance
		self.herba_items.not_payment.sum(:price) - balance
	end

	def client_credits
		total = 0
		HerbaClient.where("id > ?", 1).collect { |c| total += c.balance }
		total
	end

	def status?
		items = self.herba_items.where("date(product_date) >= ?", Date.today)
		items.present? ? true : false
	end

	def set_initial_base
		# HerbaClient.new.set_initial_base

		HerbaCategory.create(name: "Barra de Proteína")
		HerbaCategory.create(name: "Bebidas")
		HerbaCategory.create(name: "Outros")
		HerbaCategory.create(name: "Proteína")
		HerbaCategory.create(name: "Sachê")
		HerbaCategory.create(name: "Shakes")
		HerbaCategory.create(name: "Sopas")
		HerbaCategory.create(name: "Tabletes")

		HerbaProduct.create(code: "#0939", name: "Abacaxi com Hortelā", portion: 21, price: 112.0, herba_category_id: 6)
		HerbaProduct.create(code: "#0940", name: "Doce de Leite", portion: 21, price: 112.0, herba_category_id: 6)
		HerbaProduct.create(code: "#0952", name: "Chocolate Cremoso", portion: 21, price: 112.0, herba_category_id: 6)
		HerbaProduct.create(code: "#0146", name: "Cookies & Cream", portion: 21, price: 112.0, herba_category_id: 6)
		HerbaProduct.create(code: "#0951", name: "Baunilha Cremoso", portion: 21, price: 112.0, herba_category_id: 6)
		HerbaProduct.create(code: "#0946", name: "Mousse Maracujá", portion: 21, price: 112.0, herba_category_id: 6)
		HerbaProduct.create(code: "#0953", name: "Morango Cremoso", portion: 21, price: 112.0, herba_category_id: 6)
		HerbaProduct.create(code: "#0144", name: "Frutas Tropicais", portion: 21, price: 112.0, herba_category_id: 6)
		HerbaProduct.create(code: "#1199", name: "Chocolate com Coco", portion: 21, price: 112.0, herba_category_id: 6)
		HerbaProduct.create(code: "#8477", name: "Shakeira", portion: 1, price: 10.0, herba_category_id: 3)
		HerbaProduct.create(code: "#8848", name: "Braçadeira", portion: 1, price: 20.0, herba_category_id: 3)
		HerbaProduct.create(code: "#8639", name: "Pote Plástico", portion: 1, price: 3.0, herba_category_id: 3)
		HerbaProduct.create(code: "#0948", name: "Baunilha Cremoso", portion: 7, price: 40.0, herba_category_id: 5)
		HerbaProduct.create(code: "#0945", name: "Fiber Concentrate", portion: 15, price: 93.0, herba_category_id: 2)
		HerbaProduct.create(code: "#0242", name: "Pó de Proteína 240g", portion: 40, price: 101.0, herba_category_id: 4)
		HerbaProduct.create(code: "#0246", name: "Pó de Proteína 480g", portion: 80, price: 184.0, herba_category_id: 4)
		HerbaProduct.create(code: "#3114", name: "Fiber & Herb", portion: 30, price: 49.0, herba_category_id: 8)
		HerbaProduct.create(code: "#3122", name: "Multivitaminas e Minerais", portion: 45, price: 54.0, herba_category_id: 8)
		HerbaProduct.create(code: "#0130", name: "Fiberbond", portion: 30, price: 88.0, herba_category_id: 8)
		HerbaProduct.create(code: "#0020", name: "Xtra-Cal", portion: 60, price: 50.0, herba_category_id: 8)
		HerbaProduct.create(code: "#0065", name: "Herbalifeline", portion: 90, price: 129.0, herba_category_id: 8)
		HerbaProduct.create(code: "#0102", name: "NRG Pó", portion: 60, price: 74.0, herba_category_id: 2)
		HerbaProduct.create(code: "#0122", name: "NRG", portion: 30, price: 73.0, herba_category_id: 8)
		HerbaProduct.create(code: "#0255", name: "Limāo", portion: 29, price: 102.0, herba_category_id: 2)
		HerbaProduct.create(code: "#0257", name: "Pêssego", portion: 29, price: 102.0, herba_category_id: 2)
		HerbaProduct.create(code: "#0256", name: "Framboesa", portion: 29, price: 102.0, herba_category_id: 2)
		HerbaProduct.create(code: "#0105", name: "Original 50g", portion: 29, price: 102.0, herba_category_id: 2)
		HerbaProduct.create(code: "#0106", name: "Original 100g", portion: 59, price: 167.0, herba_category_id: 2)
		HerbaProduct.create(code: "#0030", name: "Brownie", portion: 7, price: 50.0, herba_category_id: 1)
		HerbaProduct.create(code: "#0031", name: "Citrus Lemon", portion: 7, price: 50.0, herba_category_id: 1)
		HerbaProduct.create(code: "#1052", name: "Frango com Legumes", portion: 7, price: 40.0, herba_category_id: 7)
		HerbaProduct.create(code: "#0554", name: "4 Queijos com Croutons", portion: 7, price: 40.0, herba_category_id: 7)
		HerbaProduct.create(code: "#1053", name: "Legumes e Verduras", portion: 7, price: 40.0, herba_category_id: 7)

		HerbaTitle.create(name: "Consumidor", discount: 0)
		HerbaTitle.create(name: "Consultor Independente", discount: 25)
		HerbaTitle.create(name: "Consultor Sênior", discount: 35)

		client = HerbaClient.create(name: "Edgard A. Mitani", email: "mitanix79@gmail.com", phone: "(43) 9926-3801")
    client.herba_address = HerbaAddress.new
    client.save
	end

	private
	def set_initial_title
		self[:herba_title_id] = 1
	end
end
