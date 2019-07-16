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
