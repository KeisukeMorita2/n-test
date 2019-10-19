require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @question = FactoryBot.create(:question)
  end
  
  context '有効な問題' do
    it '全てのカラムが入力されている' do
      expect(@question).to be_valid
    end
  end
  
  context '無効な問題' do
    it 'ユーザーがいない' do
      @question.user_id = ''
      expect(@question).to_not be_valid
    end
    
    it 'タイトルがない' do
      @question.title = ''
      expect(@question).to_not be_valid
    end
    
    it '問題文がない' do
      @question.content = ''
      expect(@question).to_not be_valid
    end
    
    it '答えがない' do
      @question.answer = ''
      expect(@question).to_not be_valid
    end
    
    it 'タイトルが２５６文字以上' do
      @question.title = 'a' * 256
      expect(@question).to_not be_valid
    end
    
    it '問題文が２５６文字以上' do
      @question.content = 'a' * 256
      expect(@question).to_not be_valid
    end
    
    it '答えが２５６文字以上' do
      @question.answer = 'a' * 256
      expect(@question).to_not be_valid
    end
    
    it '問題のタイトルが重複している' do
      @question.title = 'test1'
      question = Question.new(title: 'test1')
      question.valid?
      expect(question).to_not be_valid
    end
  end
end