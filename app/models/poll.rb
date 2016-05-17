class Poll < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  mount_uploader :avatar_1, AvatarUploader
  mount_uploader :avatar_2, AvatarUploader

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged


  def slug_candidates
    [
      :name
    ]
  end


end
