class Category < ApplicationRecord
  include SearchByName

  scope :drawing_ids, -> {
    DrawingCategory
      .where(category: ids)
      .pluck(:drawing_id)
  }

end
