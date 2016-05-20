class UsersController < ApplicationController
	before_action :check_is_admin

	def index
		@users = User.all
	end

	# def new
	# end

	# def create
	# end

	def show
		@user = User.includes(:polls, :votes).friendly.find(params[:id])
	end

	# def edit
	# end

	# def update
	# end

	def deactivate
		@user = User.friendly.find(params[:id])
		@user.update(is_active: false)
		@user.save!
		redirect_to users_path, notice: "#{@user.name} has been deactivated."
	end

	def activate
		@user = User.friendly.find(params[:id])
		@user.update(is_active: true)
		@user.save!
		redirect_to users_path, notice: "#{@user.name} has been activated."
	end

	def check_is_admin
		if is_admin?
		else
  		redirect_to root_path, notice: "Sorry, but you don't have access to this path" 
		end
	end
end