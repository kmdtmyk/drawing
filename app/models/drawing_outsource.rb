class DrawingOutsource < ApplicationRecord
  belongs_to :drawing, optional: true
  belongs_to :customer, optional: true

  delegate :name, to: :customer, prefix: true, allow_nil: true
end
