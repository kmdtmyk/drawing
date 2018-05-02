module ApplicationHelper

  def format_number(number)
    number_with_delimiter number
  end

  def format_date(date)
    date.strftime('%Y/%m/%d') if date.present?
  end

  def format_datetime(datetime)
    datetime.strftime('%Y/%m/%d %H:%M:%S') if datetime.present?
  end

  def paginate_statistic(page)
    render 'kaminari/statistic', page: page
  end

  def record_select(records, name, value, options = {})
    select_tag name,
      options_from_collection_for_select(records, 'id', 'name', value),
      include_blank: true,
      **options
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
      fa_icon('search') +
      content_tag(:span, name, class: 'tag-label-name') +
      content_tag(:span, value, class: 'tag-label-value') +
      fa_icon('close')
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

  def userstamp(record)
    render 'userstamp', record: record
  end

end
