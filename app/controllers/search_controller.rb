class SearchController < ApplicationController

	def users
		@search_key = params[:search_key]
    @users = User.search(@search_key)
    @users_count = @users.size
	end

	def polls
		@search_key = params[:search_key]
    @polls = Poll.search(@search_key)
    @polls_count = @polls.size
	end
end