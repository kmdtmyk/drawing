class Statistic::DrawingsController < ApplicationController

  def index
    @drawings = Drawing.order(:estimate_date)
  end

end
