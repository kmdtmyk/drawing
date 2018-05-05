class User::PasswordsController < ApplicationController

  def update
    @user = current_user
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to root_path, notice: 'Password was successfully updated.'
    else
      redirect_to edit_user_path, alert: @user.errors.full_messages
    end
  end

  private

    def user_params
      params.require(:user).permit(
        :password,
        :password_confirmation,
      )
    end

end
