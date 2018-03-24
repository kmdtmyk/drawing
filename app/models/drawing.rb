class Drawing < ApplicationRecord
  has_many :drawing_categories, -> { order(:display_order) }, dependent: :destroy
  has_many :categories, through: :drawing_categories
  accepts_nested_attributes_for :drawing_categories, allow_destroy: true
end
