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
		@poll = Poll.friendly.find(params[:id])
	end

	def edit
	end

	def update
	end

	private

  def poll_params
    params.require(:poll).permit(:name, :description, :avatar_1, :avatar_2)
  end


end