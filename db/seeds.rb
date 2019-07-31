50.times do |n|
  title = Faker::Music.band
  content = "seed_content"
  deadline = "2019-07-16"
  status = 1
  priority = 1
  Task.create!(title: title,
               content: content,
               deadline: deadline,
               status: status,
               priority: priority,
               )
end

#for first administrator
User.create!(name:"sysadmin",
            email:"sysadmin@dic.com",
            password: "password",
            password_confirmation: "password",
            admin: "true"
            )

5.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  admin = "true"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: admin
               )
end

10.times do |n|
  name = Faker::Book.genre
  Label.create!(name: name)
end
