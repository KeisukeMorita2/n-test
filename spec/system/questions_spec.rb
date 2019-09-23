require 'rails_helper'

describe '問題管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:question, title: '最初の問題', user: user_a)
    end
    
    context 'ユーザーA がログインしているとき' do
      before do
        visit new_session_path
        fill_in 'Eメール', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        visit questions_path
      end
      
      it 'ユーザーAが作成した問題が表示される' do
        expect(page).to have_content '最初の問題'
      end
    end
  end
end