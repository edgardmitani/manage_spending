module ApplicationHelper
	def error_tag(model, attribute)
		content_tag(:div, model.errors[attribute].first, class: "error_message") if model.errors.has_key? attribute
	end

	def format_money(value)
		value = 0 if value.nil?
		number_to_currency(value, unit: "R$", separator: ",", delimiter: ".")
	end

	def format_date(date)
		date.present? ? date.strftime("%d/%m/%Y") : ""
	end

	def format_month(date)
		date.present? ? date.strftime("%m/%y") : ""
	end

	def format_cm(value)
		if value.present?
			"#{value} cm"
		else
			"0 cm"
		end
	end

	def format_kg(value)
		if value.present?
			"#{value} kg"
		else
			"0 kg"
		end
	end

	def format_result_kg(value)
		if value.present?
			"#{number_to_currency(value, unit: "-", delimiter: ".", precision: 3)} kg"
		else
			"0 kg"
		end
	end

	def active_menu(main)
		status = ""
		case main
		when "dashboard"
			status = "active" if params[:controller] == "home"
		when "home_categories"
			status = "active" if params[:controller] == "home_categories"
		when "home_clients"
			status = "active" if params[:controller] == "home_clients"
		when "home_credit_or_debit"
			status = "active" if params[:controller] == "home_transactions" && params[:action] == "new"
		when "home_credit_card"
			status = "active" if params[:controller] == "home_transactions" && params[:action] == "new_credit_card"
		when "home_transfer"
			status = "active" if params[:controller] == "home_transactions" && params[:action] == "new_transfer"
		when "home_transactions"
			status = "active" if params[:controller] == "home_transactions" && params[:action] == "index"
		when "herba_clients"
			status = "active" if params[:controller] == "herba_clients"
		when "herba_categories"
			status = "active" if params[:controller] == "herba_categories"
		when "herba_credit_or_debit"
			status = "active" if params[:controller] == "herba_transactions" && params[:action] == "new"
		when "herba_items"
			status = "active" if params[:controller] == "herba_items"
		when "herba_profile"
			status = "active" if params[:controller] == "herba_profiles"
		when "herba_products"
			status = "active" if params[:controller] == "herba_products"
		when "herba_titles"
			status = "active" if params[:controller] == "herba_titles"
		when "herba_incomes"
			status = "active" if params[:controller] == "herba_incomes"
		when "herba_transactions"
			status = "active" if params[:controller] == "herba_transactions" && params[:action] == "index"
		end
		status
	end

	def button_name
		if params[:action] == "edit"
			t("link.edit")
		else
			t("link.add")
		end
	end

	def get_color(value)
		value < 0 ? "red" : "green"
	end
end
