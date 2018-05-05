class UsersController < ApplicationController
  before_action :set_user

  def edit
    if params[:user].present?
      @user.assign_attributes(user_params)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'User was successfully updated.'
    else
      redirect_to ({action: :edit, user: user_params}), alert: @user.errors.full_messages
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(
        :name,
        :furigana,
        :email,
      )
    end

end
