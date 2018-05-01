class DrawingFile < ApplicationRecord
  belongs_to :drawing, optional: true

  has_attached_file :file,
    styles: -> (attachment) {
      if attachment.instance.pdf?
        {
          large: ['1000x1000>', :png],
          medium: ['300x300>', :png],
        }
      elsif attachment.instance.image?
        {
          medium: '300x300>',
        }
      else
        {}
      end
    }

  validates_attachment_content_type :file,
   content_type: []

  def image?
    file_content_type.start_with? 'image/'
  end

  def pdf?
    file_content_type == 'application/pdf'
  end

  def name
    file_file_name
  end

  def url
    file.url
  end

  def large(options = {})
    if image?
      ApplicationController.helpers.image_tag file.url, **options
    elsif pdf?
      ApplicationController.helpers.image_tag file.url(:large), **options
    end
  end

  def medium(options = {})
    if image? or pdf?
      ApplicationController.helpers.image_tag file.url(:medium), **options
    end
  end

end
