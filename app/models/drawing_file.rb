class DrawingFile < ApplicationRecord
  belongs_to :drawing

  has_attached_file :file,
    styles: {
      # medium: "300x300>", thumb: "100x100>"
    }
  validates_attachment_content_type :file,
    content_type: /\Aimage\/.*\z/

end
