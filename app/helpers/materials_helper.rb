module MaterialsHelper

  def material_select(name, value, options = {})
    materials = Material.all.order(:display_order)
    record_select materials, name, value, options
  end

end
