class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable
	has_many :votes 
	has_many :polls 
	has_many :comments
	has_many :identities

  mount_uploader :avatar, AvatarUploader

  scope :active, -> { where(:is_active => true) }
  scope :in_active, -> { where(:is_active => false) }

  def self.search(search)
    return where("name LIKE ? ", "%#{search}%")
  end


  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


  def slug_candidates
    [
      :name
    ]
  end

  def is_admin?
    self.type == "Admin"
  end
  
  def is_member?
    self.type == "Member"
  end


end
