# frozen_string_literal: true

class Notice < ApplicationRecord
  include BelongsToUser

  belongs_to_user prefix: :create
  belongs_to_user prefix: :update

end
