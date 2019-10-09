class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :destroy, :new]
  before_action :correct_user, only: [:destroy, :update]
  
  def index
    @questions = Question.all.order(id: :desc).page(params[:page]).per(10)
  end
  
  def new
    if logged_in?
      @question = current_user.questions.build
    end
  end
  
  def show
   @question =  Question.find(params[:id])
  end
  
  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = '問題を作成しました。'
      redirect_to "/questions"
    else
     @questions = current_user.questions.order(id: :desc).page(params[:page])
     flash.now[:danger] = '問題を作成できませんでした。'
     render :new
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    
    if @question.update(question_params)
      flash[:success] = '問題を変更しました。'
      redirect_to @question
    else
      flash.now[:danger] = '問題の変更に失敗しました。'
      render :edit
    end
  end
    

  def destroy
    @question.destroy
    flash[:success] = '問題を削除しました。'
    redirect_to @question
  end
  
  private
  
  def question_params
    params.require(:question).permit(:title, :content, :answer, :image)
  end
  
  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    unless @question
      redirect_to root_url
    end
  end
end
