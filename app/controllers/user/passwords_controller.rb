class User::PasswordsController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to root_path, notice: 'Password was successfully updated.'
    else
      redirect_to ({action: :edit}), alert: @user.errors.full_messages
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(
        :password,
        :password_confirmation,
      )
    end

end
