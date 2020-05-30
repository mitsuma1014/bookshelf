class SessionsController < ApplicationController
  skip_before_action :login_required
  
  def new
  end

  def create
    @user = User.find_by(email:session_params[:email])
    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      #本来は読書記録一覧へリダイレクトさせるが、暫定的にユーザー詳細画面へリダイレクト
      redirect_to @user,notice: "ユーザー「#{@user.name}」がログインしました。"
    else
      flash.now.alert = "名前とパスワードが一致しません"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "ログアウトしました。"
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
