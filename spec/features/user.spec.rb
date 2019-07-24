require 'rails_helper'

RSpec.feature "ユーザー管理機能", type: :feature do
  background do
    @user1 = create(:user1)
    @user2 = create(:user2)
    @tasktest1 = create(:task, user: @user1)
    @tasktest2 = create(:second_task, user: @user2)
  end

  context 'ログイン・ログアウト可否テスト' do
    background do
      visit new_session_path
      fill_in "session_email", with: 'testuser1@dic.com'
      fill_in "session_password", with: 'password'
      click_on 'ログインする'
    end

    scenario "ログイン実施テスト" do
      expect(page).to have_content 'ログインしました'
    end

    scenario "ログアウト実施テスト" do
      click_link 'logout_link'
      expect(page).to have_content 'ログアウトしました'
    end
  end

  context 'ログインしていない状態でのアクセス制御' do
    scenario "tasks#indexへのアクセス不可" do
      visit tasks_path
      expect(page).to have_content 'ログインしてください'
    end

    scenario "tasks#newへのアクセス不可" do
      visit new_task_path
      expect(page).to have_content 'ログインしてください'
    end

    scenario "tasks#showへのアクセス不可" do
      visit task_path(@tasktest1.id)
      expect(page).to have_content 'ログインしてください'
    end

    scenario "tasks#editへのアクセス不可" do
      visit edit_task_path(@tasktest1.id)
      expect(page).to have_content 'ログインしてください'
    end

    scenario "users#showへのアクセス不可" do
      visit user_path(@user1.id)
      expect(page).to have_content 'ログインしてください'
    end
  end

  context 'ログイン状態でのアクセス制御' do
    background do
      # user1でログイン
      visit new_session_path
      fill_in "session_email", with: 'testuser1@dic.com'
      fill_in "session_password", with: 'password'
      click_on 'ログインする'
    end

    scenario "別ユーザのusers#showへのアクセス不可" do
      visit user_path(@user2.id)
      expect(page).to have_content '権限がありません'
    end

    scenario "別ユーザのtasks#showへのアクセス不可" do
      visit task_path(@tasktest2.id)
      expect(page).to have_content '権限がありません'
    end

    scenario "別ユーザのtasks#editへのアクセス不可" do
      visit edit_task_path(@tasktest2.id)
      expect(page).to have_content '権限がありません'
    end

    scenario "ユーザー登録画面へのアクセス不可" do
      visit new_user_path
      expect(page).to have_content 'すでにログイン中です'
    end
  end
end
