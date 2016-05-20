class CommentsController < ApplicationController
  before_action :authenticate_user!
	before_action :authorization_of_user, only: [:update, :edit, :remove]

	def create
		@poll = Poll.friendly.find(params[:comment][:poll_id])
		comment = @poll.comments.create(user_id: current_user.id, body: params[:comment][:body])
    if comment.save
      redirect_to poll_path(@poll), notice: 'Comment is successfully posted.'
    else
      redirect_to poll_path(@poll), notice: 'Posting comment failed. Please try again'
    end
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.includes(:poll).find(params[:id])
		@comment.update(body: params[:comment][:body])
		@comment.save!
		redirect_to poll_path(@comment.poll), notice: "Selected comment has been updated."
	end

	def remove
		@comment = Comment.includes(:poll).find(params[:id])
		@comment.update(is_active: false)
		@comment.save!
		redirect_to poll_path(@comment.poll), notice: "Selected comment has been removed."
	end

	private

	  def authorization_of_user
  	poll = Poll.friendly.find(params[:id])
  	if (current_user.polls.include? poll) || is_admin?
  		true
  	else
  		redirect_to root_path, notice: "Sorry, but you don't have access to this path" 
  	end
  end

end