class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :provider
  validates_uniqueness_of :user_id, :scope => :provider

    def self.find_for_oauth(auth)
    identity = find_by(provider: auth.provider, uid: auth.uid)
    identity = create(uid: auth.uid, provider: auth.provider) if identity.nil?
    identity.accesstoken = auth.credentials.token
    identity.name = auth.info.name
    identity.nickname = auth.info.nickname
    identity.save
    identity
  end

end
