class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @reviews = @user.reviews.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    return facebook_login if request.env['omniauth.auth'].present? #facebookログイン
    normal_login   #通常ログイン
  end

  def facebook_login
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.save(context: :facebook_login)
      session[:user_id] = @user.id
      redirect_to @user, notice: "ユーザー「#{@user.name}」がログインしました。" 
    else 
      flash.now[:notice] = "facebookでのログインに失敗しました。"
      render :new
    end
  end

  def normal_login
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "ユーザー「#{@user.name}」がログインしました。" 
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :root, notice: "ユーザー情報を削除しました。"
  end

  
  def auth_failure
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile, :password, :password_confirmation,:image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to @user
    end
  end
end
