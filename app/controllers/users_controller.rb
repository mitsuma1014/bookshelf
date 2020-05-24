class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path, notice: "ユーザー情報を更新しました。"
  end

  def destroy
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile, :password, :password_confirmation,:image)
  end
end
