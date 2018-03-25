module ApplicationHelper

  def format_number(number)
    number_with_delimiter number
  end

  def paginate_statistic(page)
    render 'kaminari/statistic', page: page
  end

end
