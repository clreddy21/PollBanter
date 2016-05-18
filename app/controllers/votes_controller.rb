class VotesController < ApplicationController
  before_action :authenticate_user!

	def create
		@poll = Poll.friendly.find(params[:vote][:poll_id])
		voted_option = params[:vote][:voted_option]
		if (@poll.vote_option_1 == voted_option) || (@poll.vote_option_2 == voted_option)
			voted_option_value = (@poll.vote_option_1 == @voted_option)? 1 : 2
			@vote = @poll.votes.create(user_id: current_user.id, voted_option: voted_option_value)
      if @vote.save
        redirect_to poll_path(@poll), notice: 'Vote is successfully casted.'
      else
        redirect_to poll_path(@poll), notice: 'Casting vote failed. Please try again'
      end
		else
			redirect_to poll_path(@poll), notice: 'Casting vote failed. Please try again'
		end
	end

	def update
		@vote = Vote.find(params[:id])
		@poll = @vote.poll
		@voted_option = params[:vote][:voted_option]

		if (@poll.vote_option_1 == @voted_option) || (@poll.vote_option_2 == @voted_option)
			voted_option_value = (@poll.vote_option_1 == @voted_option)? 1 : 2
			@vote.update(voted_option: voted_option_value)
      if @vote.save!
        redirect_to poll_path(@poll), notice: 'Vote is successfully updated.'
      else
        redirect_to poll_path(@poll), notice: 'Updating vote failed. Please try again'
      end
		else
			redirect_to poll_path(@poll), notice: 'Updating vote failed. Please try again'
		end
	end
end