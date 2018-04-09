class Statistic::DrawingsController < ApplicationController

  def index
    @drawings = Drawing
      .where.not(estimate_date: nil)
      .where.not(customer: nil)
      .order(:estimate_date)
  end

end
