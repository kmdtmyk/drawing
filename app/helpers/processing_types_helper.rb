module ProcessingTypesHelper

  def processing_type_select(name, value, options = {})
    processing_types = ProcessingType.all.order(:display_order)
    record_select processing_types, name, value, options
  end

end
