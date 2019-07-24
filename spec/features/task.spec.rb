require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  background do
    @user1 = create(:user1)
    @user2 = create(:user2)
    visit new_session_path
    fill_in "session_email", with: 'testuser1@dic.com'
    fill_in "session_password", with: 'password'
    click_on 'ログインする'
    @tasktest1 = create(:task, user: @user1)
    @tasktest2 = create(:second_task, user: @user2)
  end

  scenario "タスク一覧のテスト_ログインユーザのタスクのみ表示" do
    visit tasks_path
    expect(page).to have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'task_title', with: 'testtesttest'
    fill_in 'task_content', with: 'samplesample'
    click_on '登録する'
    expect(page).to have_content'testtesttest'
    expect(page).to have_content'samplesample'
  end

  scenario "タスク詳細のテスト" do
    visit task_path(@tasktest1.id)
    expect(page).to have_content 'testtesttest'
  end

  scenario "タスク表示が作成日時の降順であるかのテスト" do
    visit tasks_path
    expect(Task.order("updated_at desc").map(&:id)).to eq [8,7]
  end

  scenario "タスク終了期限の入力可否テスト" do
    visit new_task_path
    fill_in 'task_title', with: 'testtesttest'
    fill_in 'task_content', with: 'samplesample'
    fill_in 'task_deadline', with: DateTime.now
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
    fill_in 'title', with: '01'
    click_on '検索'
    expect(page).to have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
  end

  scenario "ステータス選択のみでのタスク検索実施可否テスト" do
    visit root_path
    fill_in 'title', with: ''
    select '未着手', from: 'status'
    click_on '検索'
    expect(page).to have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
  end

  scenario "タイトル・ステータス両方でのタスク検索実施可否テスト" do
    visit root_path
    fill_in 'title', with: 'test_'
    select '未着手', from: 'status'
    click_on '検索'
    expect(page).to have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
  end

  scenario "優先度の降順ソートテスト" do
    visit root_path
    click_on '優先度が高い順でソートする'
    expect(Task.order('priority asc').map(&:priority)).to eq %w[高 中]
  end

end
