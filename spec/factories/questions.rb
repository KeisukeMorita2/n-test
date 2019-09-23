FactoryBot.define do
  factory :question do
    title { 'テストを書く' }
    content { 'RSpec & Capybara & FactoryBotを準備する'}
    answer { '答え' }
    user
  end
end