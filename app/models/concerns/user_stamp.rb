module UserStamp
  extend ActiveSupport::Concern

  included do
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

    delegate :name,
      to: :create_user,
      prefix: true,
      allow_nil: true

    delegate :name,
      to: :update_user,
      prefix: true,
      allow_nil: true
  end

  private
    def set_create_user
      self.create_user = User.current_user
    end

    def set_update_user
      self.update_user = User.current_user
    end

end
