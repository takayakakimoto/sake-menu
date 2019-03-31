class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :following, :followers]
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @sakes = @user.sakes
    @count_want = @user.want_sakes.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = '正常に更新完了！'
      redirect_to @user
    else
      flash.now[:danger] = '更新に失敗！'
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    flash[:success] ='ユーザを削除しました。'
    redirect_to users_path
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end