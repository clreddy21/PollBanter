class Category < ActiveRecord::Base
	has_many :polls
	validates :name, :presence => {:message => 'Name cannot be blank, Category not saved'}


  scope :active, -> { where(:is_active => true) }
  scope :in_active, -> { where(:is_active => false) }

end
