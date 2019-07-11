class SessionsController < ApplicationController
  def new
  end

  def create
    #入力フォームから送られてきた情報は二段階で指定して取り出せる　downcaseで小文字化
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    #sessionで受け取ったアドレスがuserモデルに存在し、そのpasswordが合っているか確かめている
    if @user && @user.authenticate(password)
      #ログイン状態を維持している　sessionにユーザーの情報を入れている
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
