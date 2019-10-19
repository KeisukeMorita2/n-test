require 'rails_helper'

RSpec.describe '問題管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:question_a) { FactoryBot.create(:question, title: '最初の問題', user: user_a) }
  
  shared_examples_for 'ユーザーAが作成した問題が表示される' do
    it { expect(page).to have_content '最初の問題' }
  end
  
  before do
    visit new_session_path
    fill_in 'Eメール', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
  end
  
  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      
    before do
      visit questions_path
    end
      
      it_behaves_like 'ユーザーAが作成した問題が表示される'
    end
    
    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }
      
    before do
      visit questions_path
    end
      
      it_behaves_like 'ユーザーAが作成した問題が表示される'
    end
  end
    
  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      
      before do
        visit question_path(question_a)
      end
      
      it_behaves_like 'ユーザーAが作成した問題が表示される'
    end
  end
  
  describe '新規作成機能' do
    context 'ユーザーがログインしているとき' do
      let(:login_user) { user_a }
      let(:question_content) { '新規作成テスト' }
    
      before do
        visit new_question_path
      end
    
      it '新規作成画面' do
        expect(page).to have_content '作成'
      end
    end
  end
  
  describe '問題削除機能' do
    context '自身の問題は削除できる' do
      let(:login_user) { user_a }
      
      before do
        visit question_path(question_a)
        click_link '削除'
        page.accept_confirm '削除しますか？'
      end
      
      it '正常に削除される' do
        expect(page).to have_content '問題を削除しました。'
      end
    end
    
    context '他ユーザーの問題は削除できない' do
      let(:login_user) { user_b }
      
      before do
        visit question_path(question_a)
      end
      
      it '削除のリンクは表示されない' do
        expect(page).not_to have_content '削除'
      end
    end
  end
  
  describe '問題編集機能' do
    context '問題を編集できる場合' do
      let(:login_user) { user_a }
      
      before do
        visit question_path(question_a)
        click_link '編集'
      end
      
      it '編集画面に遷移する' do
        expect(current_path).to eq edit_question_path(question_a)
      end
      
      it '全てのフォーム欄の入力をすることで編集できる' do
        fill_in 'タイトル', with: 'タイトル'
        fill_in '問題', with: '問題'
        fill_in '答え', with: '答え'
        click_button '作成'
        expect(page).to have_content '問題を変更しました。'
      end
    end
    
    context '問題を編集できない場合' do
      let(:login_user) { user_b }
      
      before do
        @question = FactoryBot.create(:question, user: user_b)
      end
      
      context '他ユーザーの問題は編集できない' do
        
        before do
          visit question_path(question_a)
        end
      
        it '編集リンクは表示されない' do
          expect(page).not_to have_content '編集'
        end
      end
        
      context 'いずれかのフォーム欄が空欄' do
        
        before do
          visit question_path(@question)
          click_link '編集'
        end
        
        it 'タイトルがない' do
          fill_in 'タイトル', with: ''
          click_button '作成'
          expect(page).to have_content '問題の変更に失敗しました。'
        end
        
        it '問題文がない' do
          fill_in '問題', with: ''
          click_button '作成'
          expect(page).to have_content '問題の変更に失敗しました。'
        end
        
        it '答えがない' do
          fill_in '答え', with: ''
          click_button '作成'
          expect(page).to have_content '問題の変更に失敗しました。'
        end
      end
    end
  end
end
