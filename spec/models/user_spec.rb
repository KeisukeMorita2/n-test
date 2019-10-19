require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  
  context '有効なユーザー' do
    it 'ユーザーの名前、メールアドレス、パスワードが有効' do
      expect(@user). to be_valid
    end
  end
  
  context '無効なユーザー' do
    it 'ユーザー名がない' do
      user = User.create(name: nil)
      user.valid?
      expect(user.errors[:name]).to include "can't be blank"
    end
    
    it 'ユーザー名が２１文字以上' do
      user = User.create(name: 'ArnoldAloisSchwarzenegger')
      user.valid?
      expect(user).to_not be_valid
    end
    
    it 'メールアドレスがない' do
      user = User.create(email: nil)
      user.valid?
      expect(user.errors[:email]).to include "can't be blank"
    end
    
    it 'メールアドレスに@がない' do
      user = User.create(email: 'test1.com')
      user.valid?
      expect(user).to_not be_valid
    end
    
    it 'パスワードがない' do
      user = User.create(password: nil)
      user.valid?
      expect(user.errors[:password]).to include "can't be blank"
    end
    
    it '登録するEメールが重複している' do
      @user.email = 'test@example.com'
      user = User.new(email: 'test@example.com')
      user.valid?
      expect(user).to_not be_valid
    end
  end
end