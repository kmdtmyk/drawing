# frozen_string_literal: true

class Statistic::DrawingsParameter < Rparam::Parameter

  def index
    param :from_month, type: Date, save: true
    param :to_month, type: Date, save: true
    param :data, save: true
    param :group, save: true
  end

end
