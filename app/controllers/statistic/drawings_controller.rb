# frozen_string_literal: true

class Statistic::DrawingsController < ApplicationController
  before_action :apply_rparam

  def index
    @drawings = Drawing
      .where.not(estimate_date: nil)
      .order(:estimate_date)
  end

end
