module MaterialsHelper

  def material_select(name, value, options = {})
    materials = Material.all.order(:display_order)
    select_tag name,
      options_from_collection_for_select(materials, 'id', 'name', value),
      include_blank: true,
      **options
  end

end
