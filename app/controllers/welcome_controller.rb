class WelcomeController < ApplicationController
  # before_action :authenticate_user!

  def index
  	@polls = Poll.all.includes(:votes, :comments)
  end

end
