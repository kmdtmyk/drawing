class Drawing < ApplicationRecord
  has_many :drawing_categories, -> { order(:display_order) }, dependent: :destroy
  has_many :categories, through: :drawing_categories
  accepts_nested_attributes_for :drawing_categories, allow_destroy: true

  scope :search, -> (params){
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

    drawings
  }

end
