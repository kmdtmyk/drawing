class Drawing < ApplicationRecord
  has_many :drawing_categories, -> { order(:display_order) }, dependent: :destroy
  has_many :categories, through: :drawing_categories
  accepts_nested_attributes_for :drawing_categories, allow_destroy: true

  has_many :drawing_outsources, -> { order(:display_order) }, dependent: :destroy
  accepts_nested_attributes_for :drawing_outsources, allow_destroy: true

  belongs_to :customer, optional: true

  delegate :name, to: :customer, prefix: true, allow_nil: true

  scope :search_by_params, -> (params){
    drawings = all
    if params[:part_number].present?
      drawings.where!('LOWER(part_number) LIKE LOWER(?)', "%#{params[:part_number]}%")
    end

    if params[:order_date_from].present?
      drawings.where!('order_date >= ?', params[:order_date_from])
    end
    if params[:order_date_to].present?
      drawings.where!('order_date <= ?', params[:order_date_to])
    end

    if params[:estimated_price_from].present?
      drawings.where!('estimated_price >= ?', params[:estimated_price_from])
    end
    if params[:estimated_price_to].present?
      drawings.where!('estimated_price <= ?', params[:estimated_price_to])
    end

    if params[:difficulty_from].present?
      drawings.where!('difficulty >= ?', params[:difficulty_from])
    end
    if params[:difficulty_to].present?
      drawings.where!('difficulty <= ?', params[:difficulty_to])
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

end
