class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :destroy, :new]
  before_action :correct_user, only: [:destroy]
  
  def index
    @questions = Question.all
  end
  
  def new
    if logged_in?
      @question = current_user.questions.build
    end
  end
  
  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = '問題を作成しました。'
      redirect_to root_url
    else
     @questions = current_user.questions.order(id: :desc).page(params[:page])
     flash.now[:danger] = '問題を作成できませんでした。'
     render 'toppages/index'
    end
  end

  def destroy
    @question.destroy
    flash[:success] = '問題を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def question_params
    params.require(:question).permit(:title, :content, :answer)
  end
  
  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    unless @question
      redirect_to root_url
    end
  end
end
