module DrawingsHelper

  def search_tag_label(params, key, label, text: nil, suffix: '')
    return unless params[key].present?
    next_params = params.reject do |name|
      name == key.to_s
    end

    text = params[key] if text.nil?
    link_to drawings_path(params: next_params.to_h) do
      tag_label(label, text + suffix)
    end
  end

end
