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
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'タイトル', with: 'testtesttest'
    fill_in 'タスク内容', with: 'samplesample'
    click_on '登録する'
    expect(page).to have_content'testtesttest'
    expect(page).to have_content'samplesample'
  end

  scenario "タスク詳細のテスト" do
    @task = Task.create!(title: 'test_task_01', content: 'testtesttest')
    visit task_path(@task.id)
    expect(page).to have_content 'testtesttest'
  end

  scenario "タスク表示が作成日時の降順であるかのテスト" do
    visit tasks_path
    expect(Task.order("updated_at desc").map(&:id)).to eq [9,8]
  end

  scenario "タスク終了期限の入力可否テスト" do
    visit new_task_path
    fill_in 'タイトル', with: 'testtesttest'
    fill_in 'タスク内容', with: 'samplesample'
    fill_in '終了期限', with: DateTime.now
    click_on '登録する'
    expect(page).to have_content '2019'
  end

   scenario "タスク終了期限順のソート可否テスト" do
    visit root_path
    click_on '終了期限でソートする'
    @tasks = Task.all.order("deadline desc")
    expect(@tasks[0].deadline > @tasks[1].deadline).to be true
  end

    scenario "タイトル入力のみでのタスク検索実施可否テスト" do
      visit root_path
      fill_in 'title', with: '02'
      click_on '検索'
      expect(page).to have_content 'samplesample'
      expect(page).to_not have_content 'testtesttest'
    end

    scenario "ステータス選択のみでのタスク検索実施可否テスト" do
      visit root_path
      fill_in 'title', with: ''
      select '未着手', from: 'status'
      click_on '検索'
      expect(page).to have_content 'testtesttest'
      expect(page).to_not have_content 'samplesample'
    end

    scenario "タイトル・ステータス両方でのタスク検索実施可否テスト" do
      visit root_path
      fill_in 'title', with: 'test_'
      select '着手中', from: 'status'
      click_on '検索'
      expect(page).to have_content 'samplesample'
      expect(page).to_not have_content 'testtesttest'
    end

end
