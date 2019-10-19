class AddIndexToQuestionsTitle < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, :title, unique: true
  end
end
