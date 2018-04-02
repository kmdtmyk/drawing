class DrawingsController < ApplicationController
  before_action :set_drawing, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit]
  before_action :set_orders, only: [:new, :edit]
  before_action :set_outsources, only: [:new, :edit]

  # GET /drawings
  # GET /drawings.json
  def index
    @drawings = Drawing
      .search_by_params(params)
      .page(params[:page])
      .per(100)
    @categories = Category.all.order(:display_order)
  end

  # GET /drawings/1
  # GET /drawings/1.json
  def show
  end

  # GET /drawings/new
  def new
    @drawing = Drawing.new
  end

  # GET /drawings/1/edit
  def edit
  end

  # POST /drawings
  # POST /drawings.json
  def create
    @drawing = Drawing.new(drawing_params)

    respond_to do |format|
      if @drawing.save
        format.html { redirect_to @drawing, notice: 'Drawing was successfully created.' }
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
        format.html { redirect_to @drawing, notice: 'Drawing was successfully updated.' }
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
      format.html { redirect_to drawings_url, notice: 'Drawing was successfully destroyed.' }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def drawing_params
      params.require(:drawing).permit(
        :part_number,
        :order_date,
        :estimated_price,
        :difficulty,
        :customer_id,
        :product_name,
        :material,
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
      )
    end

end
