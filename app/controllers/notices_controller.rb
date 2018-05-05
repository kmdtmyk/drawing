class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]

  def index
    @notices = Notice.all.order(post_datetime: :desc)
  end

  def new
    @notice = Notice.new
  end

  def edit
  end

  def create
    @notice = Notice.new(notice_params)
    @notice.post_datetime = DateTime.now
    if @notice.save
      redirect_to notices_url, notice: 'お知らせの作成に成功しました'
    else
      render :new
    end
  end

  def update
    if @notice.update(notice_params)
      redirect_to notices_url, notice: 'お知らせの更新に成功しました'
    else
      render :edit
    end
  end

  def destroy
    @notice.destroy
    redirect_to notices_url, notice: 'お知らせの削除に成功しました'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notice_params
      params.require(:notice).permit(
        :title,
        :body,
        :post_datetime,
      )
    end
end
