# frozen_string_literal: true

module FormatHelper

  def format_number(number)
    number_with_delimiter number
  end

  def format_date(date)
    date.strftime('%Y/%m/%d') if date.present?
  end

  def format_datetime(datetime)
    datetime.strftime('%Y/%m/%d %H:%M:%S') if datetime.present?
  end

end
