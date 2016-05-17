class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable
	has_many :votes 
	has_many :polls 
	has_many :comments
	has_many :identities

  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def twitter_client
    @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
  end

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
  end

  def slug_candidates
    [
      :name
    ]
  end


end
