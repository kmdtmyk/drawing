# frozen_string_literal: true

class Customer < ApplicationRecord
  include BelongsToUser

  belongs_to_user prefix: :create
  belongs_to_user prefix: :update

end
