class UsersController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def destroy
  end

  def create
  end

  def show
    @user = User.find(params[:id])
  end
end
