class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def show
   
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #本来は読書記録一覧へリダイレクトさせるが、暫定的にユーザー詳細画面へリダイレクト
      redirect_to @user, notice: "ユーザー「#{@user.name}」を登録しました。" 
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
    user = User.find(params[:id])
    user.destroy
    redirect_to :root, notice: "ユーザー情報を削除しました。"
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile, :password, :password_confirmation,:image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
