class Drawings::ThumbnailsController < ApplicationController
  before_action :set_drawing, only: [:edit, :update]

  def edit
  end

  def update
    if @drawing.update(drawing_params)
      redirect_to @drawing, notice: 'Thumbnail was successfully updated.'
    else
      redirect_to action: :edit, drawing: drawing_params
    end
  end

  private

    def set_drawing
      @drawing = Drawing.find(params[:drawing_id])
    end

    def drawing_params
      params.require(:drawing).permit(
        :thumbnail_drawing_file_id
      )
    end

end
