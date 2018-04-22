class Admin::Controller < ApplicationController
  before_action :authenticate

  private

    def authenticate
      not_found unless user_signed_in? and current_user.admin?
    end

end
