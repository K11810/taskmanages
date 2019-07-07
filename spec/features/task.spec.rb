require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    create(:task)
    create(:second_task)
  end

  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
    # テストのテスト用
    # expect(page).to have_content 'for_error'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'タイトル', with: 'testtesttest'
    fill_in '内容', with: 'samplesample'
    click_on '登録する'
    expect(page).to have_content'testtesttest'
    expect(page).to have_content'samplesample'
    # テストのテスト用
    # expect(page).to have_content'for_error'
  end

  scenario "タスク詳細のテスト" do
    @task = Task.create!(title: 'test_task_01', content: 'testtesttest')
    visit task_path(@task.id)
    expect(page).to have_content 'testtesttest'
    # テストのテスト用
    # expect(page).to have_content'for_error'
  end

  scenario "タスク表示が作成日時の降順であるかのテスト" do
    visit tasks_path
    expect(Task.order("updated_at desc").map(&:id)).to eq [9,8]
    # テストのテスト用
    # expect(Task.order("updated_at asc").map(&:id)).to eq [9,8]
  end

end
