class DrawingOutsource < ApplicationRecord
  belongs_to :drawing, optional: true
  belongs_to :customer, optional: true
end
