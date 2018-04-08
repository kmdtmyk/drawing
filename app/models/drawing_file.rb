class DrawingFile < ApplicationRecord
  belongs_to :drawing, optional: true

  has_attached_file :file,
    styles: -> (attachment) {
      if attachment.instance.pdf?
        {thumbnail: ['300x300>', :png]}
      else
        {}
      end
    }

  validates_attachment_content_type :file,
    content_type: [
      /\Aimage\/.*\z/,
      'text/plain',
      'application/pdf',
    ]

  def image?
    file_content_type.start_with? 'image/'
  end

  def pdf?
    file_content_type == 'application/pdf'
  end

  def output
    ApplicationController.helpers.link_to file.url do
      if image?
        ApplicationController.helpers.image_tag file.url
      else
        file.original_filename
      end
    end
  end

end
