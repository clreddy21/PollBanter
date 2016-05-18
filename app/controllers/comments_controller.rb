class CommentsController < ApplicationController
	def create
		@poll = Poll.friendly.find(params[:comment][:poll_id])
		comment = @poll.comments.create(user_id: current_user.id, body: params[:comment][:body])
    if comment.save
      redirect_to poll_path(@poll), notice: 'Comment is successfully posted.'
    else
      redirect_to poll_path(@poll), notice: 'Posting comment failed. Please try again'
    end

	end
end