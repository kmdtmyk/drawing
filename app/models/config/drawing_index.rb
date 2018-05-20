class Config::DrawingIndex
  include ActiveModel::Model

  @permits = [
    :display_mode,
    :sort,
    :order,
    {thumbnail_display_items: []},
    {list_display_items: []},
  ]

  @attributes = @permits
    .map{|value| value.is_a?(Hash) ? value.keys : value }
    .flatten

  def initialize(attributes={})
    super
    @display_mode ||= 'thumbnail'
    @sort ||= 'estimate_date'
    @order ||= 'desc'
    @thumbnail_display_items ||= [
      'estimate_date',
      'order_customer',
      'product_name',
      'part_number',
    ]
    @list_display_items ||= [
      'estimate_date',
      'order_customer',
      'product_name',
      'part_number',
    ]
  end

  attr_accessor *@attributes

  def display_items
    return list_display_items if display_mode == 'list'
    return thumbnail_display_items
  end

  def self.permits
    @permits
  end

  def self.attributes
    @attributes
  end

  def self.display_modes
    [
      ['サムネイル', 'thumbnail'],
      ['一覧', 'list'],
    ]
  end

  def self.display_items
    [
      ['見積もり日', 'estimate_date'],
      ['受注先', 'order_customer'],
      ['品名', 'product_name'],
      ['品番', 'part_number'],
      ['材質', 'material'],
      ['加工種類', 'processing_type'],
      ['板厚', 'thickness'],
      ['幅', 'width'],
      ['長さ', 'length'],
      ['状態', 'status'],
      ['材料費', 'material_cost'],
      ['加工費', 'process_cost'],
      ['売価', 'sales_price'],
      ['メモ', 'memo'],
    ]
  end

  def self.sort_items
    [
      ['見積もり日', 'estimate_date'],
      ['売価', 'sales_price'],
    ]
  end

  def self.order_items
    [
      ['昇順', 'asc'],
      ['降順', 'desc'],
    ]
  end

end
