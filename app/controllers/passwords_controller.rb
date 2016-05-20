class PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def change_password

  end
    
  def update_password

    old_password = params[:user_old_password].to_s
    new_password = params[:user_new_password].to_s
    confirm_password = params[:user_confirm_password].to_s

    if (old_password.blank? || new_password.blank? || confirm_password.blank?)
      redirect_to change_passwords_path, notice: 'Please fill all the fields'

    else
      if new_password.strip.length > 5 && new_password.strip.length < 37
        if current_user.valid_password?(old_password)
          if new_password == confirm_password
            @user = current_user
            current_user.update(password: new_password)
            sign_in @user, :bypass => true
            redirect_to home_path, notice: 'Password changed successfully'
          else
            redirect_to change_passwords_path, notice: 'New and confirm password did not match'
          end
        else
          redirect_to change_passwords_path, notice: 'Incorrect Old Password'
        end
      else
        redirect_to change_passwords_path, notice: 'Password should be of 6 to 36 charecters'
      end
    end

  end

end
