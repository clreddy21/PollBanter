class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    generic_callback( 'facebook' )
  end

  def twitter
    generic_callback( 'twitter' )
  end

  def upgrade
    scope = nil
    if params[:provider] == "google_oauth2"
      scope = "email,profile,offline,https://www.googleapis.com/auth/admin.directory.user"
    end

    redirect_to user_omniauth_authorize_path( params[:provider] ), flash: { scope: scope }
  end

  def setup
    request.env['omniauth.strategy'].options['scope'] = flash[:scope] || request.env['omniauth.strategy'].options['scope']
    render :text => "Setup complete.", :status => 404
  end

  def generic_callback( provider )
    auth = env["omniauth.auth"]
    @identity = Identity.find_for_oauth auth

    @user = @identity.user || User.find_by(email: auth.info.email) || current_user
    if @user.nil?
      @user = User.create( email: auth.info.email || "" )
      @identity.update_attribute( :user_id, @user.id )
    end

    if @user.email.blank? && auth.info.email
      @user.update_attribute( :email => auth.info.email, :name => @identity.name)
    end

    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )
      # This is because we've created the user manually, and Device expects a
      # FormUser class (with the validations)
      @user = FormUser.find @user.id
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end