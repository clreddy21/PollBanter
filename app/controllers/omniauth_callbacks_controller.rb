class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    auth = request.env["omniauth.auth"]
    @identity = Identity.from_omniauth(auth)

    @user = @identity.user || User.find_by(email: auth.info.email) || current_user

    if @user.nil?
      @user = User.create( name: auth.info.name, email: auth.info.email || "" )

      @user.save!
      @identity.update_attribute( :user_id, @user.id )
    end

    if @user.persisted?
      sign_in_and_redirect @user, notice: "Signed In!"
    else
      session[:devise.user_attributes] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all
end