# frozen_string_literal: true

class Statistic::DrawingsParameter < Rparam::Parameter

  def index
    param :data, save: true
    param :group, save: true
  end

end
