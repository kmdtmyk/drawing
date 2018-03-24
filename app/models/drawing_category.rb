class DrawingCategory < ApplicationRecord
  belongs_to :drawing, optional: true
  belongs_to :category
end
