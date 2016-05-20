class PollsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authorization_of_user, only: [:update, :edit, :deactivate]

	def index
	end

	def new
		@poll = Poll.new
		@categories = Category.active
	end

	def create
		@poll = current_user.polls.create(poll_params)

		respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll is successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
	end

	def show
		@poll = Poll.includes(:votes).friendly.find(params[:id])
		@comments = @poll.comments.includes(:user)
		@comment = Comment.new
		@can_edit = ((current_user.polls.include? @poll) || is_admin?) ? true : false

		@votes_details = @poll.votes_details

		if check_if_already_voted(@poll).present?
			@voted = true
			@vote = check_if_already_voted(@poll)
		else
			@voted = false
			@vote = @poll.votes.new()
		end
	end

	def edit
		@poll = Poll.friendly.find(params[:id])
	end

	def update
		@poll = Poll.friendly.find(params[:id])
		@poll.update(poll_params)
		@poll.save!

		redirect_to poll_path(@poll), :notice => "Poll has been updated successfully."
	end

	def deactivate
		@poll = Poll.friendly.find(params[:id])
		@poll.update(is_active: false)
		@poll.save!
		redirect_to @polls_path, notice: "#{@poll.name} has been removed."
	end

	def activate
		@poll = Poll.friendly.find(params[:id])
		@poll.update(is_active: true)
		@poll.save!
		redirect_to @polls_path, notice: "#{@poll.name} has been activated."
	end

	private

  def poll_params
    params.require(:poll).permit(:name, :description, :vote_option_1, :vote_option_2, :avatar_1, :avatar_2)
  end

  def check_if_already_voted(poll)
  	poll.votes.find_by(user_id: current_user.id)
  end

  def authorization_of_user
  	poll = Poll.friendly.find(params[:id])
  	if (current_user.polls.include? poll) || is_admin?
  		true
  	else
  		redirect_to root_path, notice: "Sorry, but you don't have access to this path" 
  	end
  end
end
