class Notice < ApplicationRecord
  belongs_to :create_user,
    class_name: 'User',
    foreign_key: 'create_user_id',
    optional: true

  belongs_to :update_user,
    class_name: 'User',
    foreign_key: 'update_user_id',
    optional: true

  before_create :set_create_user
  before_save :set_update_user

  private
    def set_create_user
      self.create_user = User.current_user
    end

    def set_update_user
      self.update_user = User.current_user
    end

end
