# frozen_string_literal: true

class ProcessingTypesController < ApplicationController
  before_action :set_processing_type, only: [:show, :edit, :update, :destroy]

  def index
    @processing_types = ProcessingType.all.order(:display_order)
  end

  def new
    @processing_type = ProcessingType.new
    assign_processing_type_params(@processing_type) if params[:processing_type].present?
  end

  def edit
    assign_processing_type_params(@processing_type) if params[:processing_type].present?
  end

  def create
    @processing_type = ProcessingType.new(processing_type_params)
    @processing_type.created_by(current_user)
    if @processing_type.save
      redirect_to processing_types_url, notice: '加工種類の作成に成功しました'
    else
      redirect_to action: :new, processing_type: processing_type_params
    end
  end

  def update
    @processing_type.updated_by(current_user)
    if @processing_type.update(processing_type_params)
      redirect_to processing_types_url, notice: '加工種類の更新に成功しました'
    else
      redirect_to action: :edit, processing_type: processing_type_params
    end
  end

  def destroy
    @processing_type.destroy
    redirect_to processing_types_url, notice: '加工種類の削除に成功しました'
  end

  private

    def set_processing_type
      @processing_type = ProcessingType.find(params[:id])
    end

    def processing_type_params
      params.require(:processing_type).permit(:name, :display_order)
    end

    def assign_processing_type_params(processing_type)
      processing_type.assign_attributes(processing_type_params)
      processing_type.valid?
    end

end
