class CategoriesController < ApplicationController
	before_action :check_is_admin

	def index
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def create
		category = Category.create(name: params[:category][:name], is_active: true)
		if category.save!
			redirect_to categories_path, notice: "Category added successfully."
		else
			redirect_to new_category_path, notice: "Failed to create category, please try again."
		end
	end

	def show
		@category = Category.find(params[:id])
		@polls = @category.polls.active
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		category = Category.find(params[:id])
		category.update(name: params[:category][:name])
		if category.save!
			redirect_to categories_path, notice: "Category updated successfully."
		else
			redirect_to new_category_path, notice: "Failed to update category, please try again."
		end
	end

	def deactivate
		@category = Category.find(params[:id])
		@category.update(is_active: false)
		@category.save!
		redirect_to categories_path, notice: "#{@category.name} has been deactivated."
	end

	def activate
		@category = Category.find(params[:id])
		@category.update(is_active: true)
		@category.save!
		redirect_to categories_path, notice: "#{@category.name} has been activated."
	end

	def check_is_admin
		if is_admin?
		else
  		redirect_to root_path, notice: "Sorry, but you don't have access to this path" 
		end
	end
end