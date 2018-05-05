class Admin::UsersController < Admin::Controller
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(:furigana)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to ({action: :index}), notice: 'ユーザーの作成に成功しました'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to ({action: :index}), notice: 'ユーザーの更新に成功しました'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to ({action: :index}), notice: 'ユーザーの削除に成功しました'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :name,
        :furigana,
        :email,
        :password,
        :admin,
      )
    end
end
