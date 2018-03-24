class DrawingCategory < ApplicationRecord
  belongs_to :drawing
  belongs_to :category
end
