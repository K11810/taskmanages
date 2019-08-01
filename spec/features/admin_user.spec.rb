require 'rails_helper'

RSpec.feature "管理者ユーザー機能", type: :feature do
  background do
    @user1 = create(:user1)
    @tasktest1 = create(:task, user: @user1)
    visit new_session_path
    fill_in "session_email", with: 'testuser1@dic.com'
    fill_in "session_password", with: 'password'
    click_on 'ログインする'
  end

  scenario "管理者用ユーザー一覧画面へのアクセスのテスト" do
    click_link 'admin_link'
    expect(page).to have_content '管理者用ユーザー一覧画面'
  end

  scenario "管理者用ページからのユーザー作成のテスト" do
    click_link 'admin_link'
    click_on 'ユーザー新規作成画面へ'
    fill_in 'admin_user_name',with:'testuser'
    fill_in 'admin_user_email',with:'testuser@dic.com'
    fill_in 'admin_user_password',with:'testuser'
    fill_in 'admin_user_password_confirm',with:'testuser'
    click_on '登録する'
    expect(page).to have_content 'ユーザー「testuser」を登録しました'
  end

  scenario "管理者用ページからのユーザー詳細画面表示テスト" do
    click_link 'admin_link'
    click_on '詳細'
    expect(page).to have_content '管理者用ユーザー詳細画面'
    expect(page).to have_content 'タスク数: 1'
  end

  scenario "管理者用ページからのユーザー情報更新のテスト" do
    click_link 'admin_link'
    click_on '編集'
    fill_in 'admin_user_name',with:'testuser_edit'
    fill_in 'admin_user_email',with:'testuser@dic.com'
    fill_in 'admin_user_password',with:'testuser'
    fill_in 'admin_user_password_confirm',with:'testuser'
    click_on '更新する'
    expect(page).to have_content 'testuser_edit'
  end

  # scenario "ユーザー削除のテスト" do
  #   click_link 'admin_link'
  #   click_on '削除'
  #   expect(page).to have_content 'ユーザー「testuser1」を削除しました'
  # end
end
