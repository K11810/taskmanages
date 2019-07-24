require 'rails_helper'

RSpec.feature User, type: :model do
  background do
    create(:user1)
  end

    scenario "name, email, password, password_confirmationが正しい内容で記載されていればバリデーションが通る" do
      user = User.new(name: 'test', email: 'testus@dic.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    scenario "nameが空ならバリデーションが通らない" do
      user = User.new(name: '', email: 'testuser1@dic.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    scenario "nameが31文字以上ならバリデーションが通らない" do
      user = User.new(name: 'x' * 31, email: 'testuser1@dic.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    scenario "emailが空ならバリデーションが通らない" do
      user = User.new(name: 'testuser1', email: '', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    scenario "emailがすでに存在している場合は登録できない" do
      user = User.new(name: 'testuser1', email: 'testuser1@dic.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    scenario "emailの形式が有効でなければ登録できない" do
      user = User.new(name: 'testuser1', email: 'testuser1', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    scenario "emailが256文字以上ならバリデーションが通らない" do
      user = User.new(name: 'name', email: "testuser1@dic.com.#{'a' * 256}", password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    scenario "passwordが5文字未満ならバリデーションが通らない" do
      user = User.new(name: 'name', email: 'testuser1@dic.com', password: 'xyz', password_confirmation: 'xyz')
      expect(user).not_to be_valid
    end

    scenario "passwordとpassword_confirmationが違ったらバリデーションが通らない" do
      user = User.new(name: 'name', email: 'testuser1@dic.com', password: 'password', password_confirmation: 'pass_word')
      expect(user).not_to be_valid
    end

end
