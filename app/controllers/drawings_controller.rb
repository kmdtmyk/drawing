class DrawingsController < ApplicationController
  before_action :set_drawing, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit]
  before_action :set_orders, only: [:index, :new, :edit]
  before_action :set_materials, only: [:new, :edit]
  before_action :set_processing_types, only: [:new, :edit]
  before_action :set_outsources, only: [:new, :edit]
  before_action :set_params_display_order, only: [:create, :update]
  after_action :set_thumbnail_drawing_file, only: [:create, :update]

  # GET /drawings
  # GET /drawings.json
  def index
    json = get_config
    if params[:config].present?
      json = json.merge(config_params)
    end
    @config =  Config::DrawingIndex.new(json)
    @drawings = Drawing
      .search_by_params(params)
      .order(@config.sort + ' ' + @config.order)
      .page(params[:page])
      .per(100)
    @categories = Category.all.order(:display_order)
    @search_params = search_params
    save_config(@config)
  end

  # GET /drawings/1
  # GET /drawings/1.json
  def show
  end

  # GET /drawings/new
  def new
    @drawing = Drawing.new
    @drawing.estimate_date = Date.today
    @drawing.drawing_outsources.new
    @drawing.drawing_files.new
  end

  # GET /drawings/1/edit
  def edit
    @drawing.drawing_outsources.new if @drawing.drawing_outsources.empty?
    @drawing.drawing_files.new if @drawing.drawing_files.empty?
  end

  # POST /drawings
  # POST /drawings.json
  def create
    @drawing = Drawing.new(drawing_params)

    respond_to do |format|
      if @drawing.save
        format.html { redirect_to @drawing, notice: '図面の作成に成功しました' }
        format.json { render :show, status: :created, location: @drawing }
      else
        format.html { render :new }
        format.json { render json: @drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drawings/1
  # PATCH/PUT /drawings/1.json
  def update
    respond_to do |format|
      if @drawing.update(drawing_params)
        format.html { redirect_to @drawing, notice: '図面の更新に成功しました' }
        format.json { render :show, status: :ok, location: @drawing }
      else
        format.html { render :edit }
        format.json { render json: @drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drawings/1
  # DELETE /drawings/1.json
  def destroy
    @drawing.destroy
    respond_to do |format|
      format.html { redirect_to drawings_url, notice: '図面の削除に成功しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drawing
      @drawing = Drawing.find(params[:id])
    end

    def set_categories
      @categories = Category.all.order(:display_order)
    end

    def set_outsources
      @outsources = Customer.where(outsource_flag: true).order(:display_order)
    end

    def set_orders
      @orders = Customer.where(order_flag: true).order(:display_order)
    end

    def set_materials
      @materials = Material.all.order(:display_order)
    end

    def set_processing_types
      @processing_types = ProcessingType.all.order(:display_order)
    end

    def set_params_display_order
      if params[:drawing][:drawing_files_attributes].present?
        params[:drawing][:drawing_files_attributes].each do |index, drawing_file|
          drawing_file[:display_order] = index.to_i + 1
        end
      end

      if params[:drawing][:drawing_outsources_attributes].present?
        params[:drawing][:drawing_outsources_attributes].each do |index, drawing_outsource|
          drawing_outsource[:display_order] = index.to_i + 1
        end
      end
    end

    def search_params
      params.permit(
        :estimate_date_from,
        :estimate_date_to,
        :customer_id,
        :product_name,
        :part_number,
        :material_id,
        :processing_type_id,
        :thickness_from,
        :thickness_to,
        :width_from,
        :width_to,
        :length_from,
        :length_to,
      )
    end

    def config_params
      params.require(:config).permit(Config::DrawingIndex.permits)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drawing_params
      params.require(:drawing).permit(
        :part_number,
        :order_date,
        :estimated_price,
        :difficulty,
        :customer_id,
        :product_name,
        :material_id,
        :processing_type_id,
        :thickness,
        :width,
        :length,
        :estimate_date,
        :estimate_flag,
        :order_flag,
        :suspend_flag,
        :material_cost,
        :process_cost,
        :sales_price,
        :memo,
        drawing_categories_attributes: [
          :id,
          :category_id,
          :display_order,
          :_destroy,
        ],
        drawing_outsources_attributes: [
          :id,
          :customer_id,
          :purchase_price,
          :display_order,
          :_destroy,
        ],
        drawing_files_attributes: [
          :id,
          :file,
          :display_order,
          :_destroy,
        ],
      )
    end

    def set_thumbnail_drawing_file
      return if @drawing.thumbnail_drawing_file.present?
      first_thumbnail = @drawing.thumbnail_drawing_files.first
      @drawing.thumbnail_drawing_file = first_thumbnail
      @drawing.save
    end

    def save_config(config)
      cookies[:config] = {
        value: config.to_json,
        path: URI.parse(request.fullpath).path,
        expires: 1.year.from_now,
      }
    end

    def get_config
      begin
        JSON.parse(cookies[:config])
      rescue => e
        {}
      end
    end

end
