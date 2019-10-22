class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    question = Question.find(params[:question_id])
    current_user.favorite(question)
    flash[:success] = 'お気に入り登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    question = Question.find(params[:question_id])
    current_user.unfavorite(question)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
