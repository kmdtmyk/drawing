# frozen_string_literal: true

class Statistic::DrawingsController < ApplicationController
  before_action :apply_rparam

  def index
    @drawings = Drawing
      .where.not(estimate_date: nil)
      .order(:estimate_date)

    if params[:from_month].present?
      @drawings = @drawings.where('? <= estimate_date', params[:from_month])
    end

    if params[:to_month].present?
      @drawings = @drawings.where('estimate_date <= ?', params[:to_month].end_of_month)
    end

  end

end
