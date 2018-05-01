class Drawing < ApplicationRecord
  has_many :drawing_categories, -> { order(:display_order) }, dependent: :destroy
  has_many :categories, through: :drawing_categories
  accepts_nested_attributes_for :drawing_categories, allow_destroy: true

  has_many :drawing_outsources, -> { order(:display_order) }, dependent: :destroy
  accepts_nested_attributes_for :drawing_outsources,
    allow_destroy: true,
    reject_if: :reject_drawing_outsources

  has_many :drawing_files, -> { order(:display_order) }, dependent: :destroy
  accepts_nested_attributes_for :drawing_files, allow_destroy: true

  belongs_to :thumbnail_drawing_file,
    class_name: 'DrawingFile',
    foreign_key: 'thumbnail_drawing_file_id',
    optional: true

  belongs_to :customer, optional: true
  delegate :name, to: :customer, prefix: true, allow_nil: true

  belongs_to :material, optional: true
  delegate :name, to: :material, prefix: true, allow_nil: true

  belongs_to :processing_type, optional: true
  delegate :name, to: :processing_type, prefix: true, allow_nil: true

  scope :search_by_params, -> (params){
    drawings = all

    if params[:customer_id].present?
      drawings.where!(customer_id: params[:customer_id])
    end

    if params[:product_name].present?
      drawings.where!('LOWER(product_name) LIKE LOWER(?)', "%#{params[:product_name]}%")
    end

    if params[:part_number].present?
      drawings.where!('LOWER(part_number) LIKE LOWER(?)', "%#{params[:part_number]}%")
    end

    if params[:material_id].present?
      drawings.where!(material_id: params[:material_id])
    end

    if params[:processing_type_id].present?
      drawings.where!(processing_type_id: params[:processing_type_id])
    end

    if params[:thickness_from].present?
      drawings.where!('thickness >= ?', params[:thickness_from])
    end
    if params[:thickness_to].present?
      drawings.where!('thickness <= ?', params[:thickness_to])
    end

    if params[:width_from].present?
      drawings.where!('width >= ?', params[:width_from])
    end
    if params[:width_to].present?
      drawings.where!('width <= ?', params[:width_to])
    end

    if params[:length_from].present?
      drawings.where!('length >= ?', params[:length_from])
    end
    if params[:length_to].present?
      drawings.where!('length <= ?', params[:length_to])
    end

    if params[:estimate_date_from].present?
      drawings.where!('estimate_date >= ?', params[:estimate_date_from])
    end
    if params[:estimate_date_to].present?
      drawings.where!('estimate_date <= ?', params[:estimate_date_to])
    end

    if params[:estimated_price_from].present?
      drawings.where!('estimated_price >= ?', params[:estimated_price_from])
    end
    if params[:estimated_price_to].present?
      drawings.where!('estimated_price <= ?', params[:estimated_price_to])
    end

    if params[:categories].present?
      params[:categories].each do |cateogy_id|
        drawing_ids =  DrawingCategory
          .where(category: cateogy_id)
          .drawing_ids
        drawings.where!(id: drawing_ids)
      end
    end

    drawings
  }

  def status
    array = []
    array << '見積もり' if estimate_flag
    array << '受注' if order_flag
    array << '保留' if suspend_flag
    return array.join('、')
  end

  def thumbnail(options = {})
    return if thumbnail_drawing_file.nil?
    thumbnail_drawing_file.medium **options
  end

  def thumbnail_drawing_files
    drawing_files.select do |drawing_file|
      drawing_file.image_or_pdf?
    end
  end

  private

    def reject_drawing_outsources(attributes)
      blank = attributes[:customer_id].blank? && attributes[:purchase_price].blank?
      return blank unless attributes[:id].present?
      attributes[:_destroy] = true if blank
      false
    end

end
