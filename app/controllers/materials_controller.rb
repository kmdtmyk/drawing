class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET /materials
  # GET /materials.json
  def index
    @materials = Material.all.order(:display_order)
  end

  # GET /materials/new
  def new
    @material = Material.new
    assign_material_params(@material) if params[:material].present?
  end

  # GET /materials/1/edit
  def edit
    assign_material_params(@material) if params[:material].present?
  end

  # POST /materials
  # POST /materials.json
  def create
    @material = Material.new(material_params)
    @material.created_by(current_user)
    if @material.save
      redirect_to materials_url, notice: '材質の作成に成功しました'
    else
      redirect_to action: :new, material: material_params
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    @material.updated_by(current_user)
    if @material.update(material_params)
      redirect_to materials_url, notice: '材質の更新に成功しました'
    else
      redirect_to action: :edit, material: material_params
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    redirect_to materials_url, notice: '材質の削除に成功しました'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:name, :display_order)
    end

    def assign_material_params(material)
      material.assign_attributes(material_params)
      material.valid?
    end
end
