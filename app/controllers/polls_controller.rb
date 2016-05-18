class PollsController < ApplicationController
  before_action :authenticate_user!

	def index
	end

	def new
		@poll = Poll.new
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
		
		if check_if_already_voted(@poll).present?
			@voted = true
			@vote = check_if_already_voted(@poll)
		else
			@voted = false
			@vote = @poll.votes.new()
		end
	end

	def edit
	end

	def update
	end

	private

  def poll_params
    params.require(:poll).permit(:name, :description, :vote_option_1, :vote_option_2, :avatar_1, :avatar_2)
  end

  def check_if_already_voted(poll)
  	poll.votes.find_by(user_id: current_user.id)
  end
end