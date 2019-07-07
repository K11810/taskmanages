require 'rails_helper'

RSpec.feature Task, type: :model do

  scenario "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', content: '空タイトルテスト')
    expect(task).not_to be_valid

  end

  scenario "titleが141文字以上ならバリデーションが通らない" do
    task = Task.new(title: 'x'*141, content: 'タイトルover141characterテスト')
    expect(task).not_to be_valid
  end

   scenario "contentが空ならバリデーションが通らない" do
    task = Task.new(title: '内容空テスト', content: '')
    expect(task).not_to be_valid
  end

   scenario "titleとcontentに内容が記載されていればバリデーションが通る" do
    task = Task.new(title: 'タイトル有りテスト', content: '内容有りテスト')
    expect(task).to be_valid
  end

end
