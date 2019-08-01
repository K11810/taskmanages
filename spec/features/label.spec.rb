require 'rails_helper'

 RSpec.feature "ラベル管理機能", type: :feature do

  background do
    @user1 = create(:user1)
    @user2 = create(:user2)
    @label1 = create(:label_1st)
    @label2 = create(:label_2nd)
    #adminでログイン&タスク作成
    visit new_session_path
    fill_in "session_email", with: 'testuser1@dic.com'
    fill_in "session_password", with: 'password'
    click_on 'ログインする'
    @tasktest1 = create(:task, user: @user1, labels: [@label1, @label2])
    #テスト結果比較用に一般ユーザでのタスク作成
    @tasktest2 = create(:second_task, user: @user2, labels: [@label1])
  end

  scenario "ラベル付きタスク作成テスト" do
    visit new_task_path
    fill_in 'task_title', with: 'task_with_labels_title'
    fill_in 'task_content', with: 'task_with_labels_content'
    check 'task_label_ids_1'
    check "task_label_ids_2"
    click_on '登録する'
    # 1つのタスクに複数のラベル付与が可能であること
    expect(page).to have_content'label_1st'
    expect(page).to have_content'label_2nd'
  end

  scenario "ラベル付きタスク詳細表示テスト" do
    visit task_path(@tasktest1.id)
    # 1つのタスクに複数のラベルが付与されていること
    expect(page).to have_content'label_1st'
    expect(page).to have_content'label_2nd'
  end

  scenario "ラベル検索のみでのタスク実施可否テスト" do
    visit tasks_path
    select 'label_1st', from: 'label_id'
    click_on '検索'
    expect(page).to have_content "test_task_01"
    expect(page).to have_content'label_1st'
    # 他のユーザが作成したタスクが表示されないこと
    expect(page).to_not have_content "test_task_02"
  end

  scenario "タイトル・ラベルでのタスク検索実施可否テスト" do
    visit root_path
    fill_in 'title', with: '01'
    select 'label_1st', from: 'label_id'
    click_on '検索'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content'label_1st'
    # 他のユーザが作成したタスクが表示されないこと
    expect(page).to_not have_content 'test_task_02'
  end

  scenario "ステータス・ラベルでのタスク検索実施可否テスト" do
    visit root_path
    fill_in 'title', with: ''
    select '未着手', from: 'status'
    select 'label_1st', from: 'label_id'
    click_on '検索'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content'label_1st'
    # 他のユーザが作成したタスクが表示されないこと
    expect(page).to_not have_content 'test_task_02'
  end

  scenario "タイトル・ステータス・ラベル全て入力でのタスク検索実施可否テスト" do
    visit root_path
    fill_in 'title', with: 'test_'
    select '未着手', from: 'status'
    select "label_1st", from: "label_id"
    click_on '検索'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content'label_1st'
    # 他のユーザが作成したタスクが表示されないこと
    expect(page).to_not have_content 'test_task_02'
  end

 end
