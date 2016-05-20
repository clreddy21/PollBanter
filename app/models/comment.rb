class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll

  scope :active, -> { where(:is_active => true) }
  scope :in_active, -> { where(:is_active => false) }

end
