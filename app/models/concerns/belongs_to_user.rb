# frozen_string_literal: true

module BelongsToUser
  extend ActiveSupport::Concern

  module ClassMethods

    def belongs_to_user(options = nil)
      options ||= {}
      prefix = options[:prefix]

      if prefix.present?
        name = "#{prefix}_user"
      else
        name = 'user'
      end

      foreign_key = "#{name}_id"

      belongs_to(name.to_sym,
        class_name: 'User',
        foreign_key: foreign_key,
        optional: true
      )

      define_method "#{name}_name" do
        if read_attribute(foreign_key).nil?
          return
        end

        user = send(name)

        if user.nil?
          ApplicationController.helpers.tag.small '削除済のユーザ'
        else
          user.name
        end
      end

    end

  end

  def created_by(user)
    if has_attribute? :create_user_id
      self.create_user_id = user&.id
    end
    updated_by(user)
  end

  def updated_by(user)
    if has_attribute? :update_user_id
      self.update_user_id = user&.id
    end
    self.updated_at = Time.current
  end

end
