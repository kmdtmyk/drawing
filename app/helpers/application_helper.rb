module ApplicationHelper

  def format_number(number)
    number_with_delimiter number
  end

  def format_datetime(datetime)
    datetime.strftime('%Y/%m/%d %H:%M:%S') if datetime.present?
  end

  def paginate_statistic(page)
    render 'kaminari/statistic', page: page
  end

  def table_tag(options = {})
    if options[:class].present?
      options[:class] = options[:class].split
    else
      options[:class] = []
    end
    options[:class] << [
      'table',
      'table-sm',
      'table-striped',
      'table-bordered',
      # 'table-hover',
    ]
    content_tag(:table, **options) do
      yield
    end
  end

  def tag_label(name, value = '')
    content_tag(:span, class: 'tag-label') do
      content_tag(:i, nil, class: 'fa fa-search') +
      content_tag(:span, name, class: 'tag-label-name') +
      content_tag(:span, value, class: 'tag-label-value') +
      content_tag(:i, nil, class: 'fa fa-close tag-label-delete')
    end
  end

  def hidden_params(options)
    except = Array.wrap(options[:except])
    except << :controller
    except << :action
    result = ''
    params.each do |name, value|
      next if except.include?(name.to_sym)
      result += hidden_field_tag name, value
    end
    raw result
  end

end
