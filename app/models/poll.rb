class Poll < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :votes
  has_many :comments

  mount_uploader :avatar_1, AvatarUploader
  mount_uploader :avatar_2, AvatarUploader

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  scope :active, -> { where(:is_active => true) }
  scope :in_active, -> { where(:is_active => false) }


  def self.search(search)
    # return where("name LIKE ? OR self.category LIKE ? ", "%#{search}%", "%#{search}%")
    return where("name LIKE ? ", "%#{search}%")
  end

  def votes_details
    total_votes = self.votes
    votes_for_first_option = total_votes.where(voted_option: 1).size
    votes_for_second_option = total_votes.where(voted_option: 2).size
    total_votes_count = total_votes.size

    [total_votes_count, votes_for_first_option, votes_for_second_option]
  end

  private

  def slug_candidates
    [
      :name
    ]
  end

end
