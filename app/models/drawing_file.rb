class DrawingFile < ApplicationRecord
  belongs_to :drawing, optional: true

  has_one :drawing,
    class_name: 'Drawing',
    foreign_key: 'thumbnail_drawing_file_id',
    dependent: :nullify

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

  def text?
    file_content_type == 'text/plain'
  end

  def word?
    name.end_with?('doc') or name.end_with?('docx')
  end

  def excel?
    name.end_with?('xls') or name.end_with?('xlsx')
  end

  def image_or_pdf?
    image? or pdf?
  end

  def name
    file_file_name
  end

  def icon
    if pdf?
      icon_name = 'file-pdf-o'
    elsif image?
      icon_name = 'file-image-o'
    elsif text?
      icon_name = 'file-text-o'
    elsif word?
      icon_name = 'file-word-o'
    elsif excel?
      icon_name = 'file-excel-o'
    else
      icon_name = 'file-o'
    end
    ApplicationController.helpers.fa_icon icon_name
  end

  def name_with_icon
    icon + ' ' + name
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
    if image_or_pdf?
      ApplicationController.helpers.image_tag file.url(:medium), **options
    end
  end

end
