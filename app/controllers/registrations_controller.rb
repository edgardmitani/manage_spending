class RegistrationsController < ApplicationController
	def new
    flash.now[:info] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end

  def create
    flash.now[:info] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end
end
