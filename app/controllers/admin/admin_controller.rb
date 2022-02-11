class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
	before_action :check_permission

	def check_permission
		unless current_user.is_admin?
      redirect_to root_path
		end
	end
end
