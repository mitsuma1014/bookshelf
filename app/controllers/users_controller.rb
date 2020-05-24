class UsersController < ApplicationController
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
  end

  def destroy
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
