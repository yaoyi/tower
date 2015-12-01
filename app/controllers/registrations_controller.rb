# coding: utf-8
class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters
	protected
	   #  def after_inactive_sign_up_path_for(resource)
	   #  	session[:previous_url] || home_path
	  	# end
		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up).push(:nickname)
		end
end