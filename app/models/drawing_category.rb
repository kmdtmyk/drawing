class DrawingCategory < ApplicationRecord
  belongs_to :drawing, optional: true
  belongs_to :category

  scope :drawing_ids, -> {
    pluck(:drawing_id)
  }

end
