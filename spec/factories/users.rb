FactoryBot.define do

  factory :user1, class: User do
    name { "testuser1" }
    email { "testuser1@dic.com" }
    password { "password" }
    admin {"true"}
  end

  factory :user2, class: User do
    name { "testuser2" }
    email { "testuser2@dic.com" }
    password { "password" }
  end

end
