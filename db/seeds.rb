############################## USERS ##############################
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@email.com"
  course = Faker::Educator.course
  university = Faker::Educator.university
  password = "password"
  User.create!(name:  name,
               email: email,
               course: course,
               organization: university,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

User.create!(name:  "Example User",
             email: "example@email.com",
             password:              "123456",
             password_confirmation: "123456",
             activated: true,
             activated_at: Time.zone.now)

############################## GROUPS ##############################
Group.create!(name: "Banco de Dados",
              area: "Computação",
              description: "Estudos sobre a displina",
              private: false)

Group.create!(name: "Engenharia de Software",
              area: "Computação",
              description: "Estudos sobre a displina",
              private: false)

Group.create!(name: "Projeto e Análise de algoritmos",
              area: "Computação",
              description: "Estudos sobre a displina",
              private: true)

20.times do |n|
  name = Faker::Company.name
  area = Faker::Company.industry
  description = Faker::Company.buzzword
  Group.create!(name: name,
                area: area,
                description: description,
                private: false)
end


############################## MEMBERS ##############################
Member.create!(group_id: Group.first.id,
               user_id: User.first.id,
               admin: true,
               pending: false)

Member.create!(group_id: Group.second.id,
               user_id: User.first.id,
               admin: true,
               pending: false)

for n in 1...20
  Member.create!(group_id: Group.first.id,
                 user_id: User.find(n).id,
                 admin: false,
                 pending: false)
end

for n in 1...20
  Member.create!(group_id: Group.second.id,
                 user_id: User.find(n).id,
                 admin: false,
                 pending: false)
end

for n in 1...55
  Member.create!(group_id: Group.find(5).id,
                 user_id: User.find(n).id,
                 admin: false,
                 pending: false)
end
############################## TASKS ##############################
@priorities = %w[Baixa Normal Alta Máxima]

for n in 1...20
  title = Faker::Company.bs
  priority = @priorities[rand(4)]
  deadline = Faker::Time.forward(30, :morning)
  description = Faker::Hacker.say_something_smart
  Task.create!(title: title,
               priority: priority,
               deadline: deadline,
               description: description,
               active: true,
               group_id: Group.first.id,
               user_id: User.find(n).id)
end

for n in 1...10
  title = Faker::Company.bs
  priority = @priorities[rand(4)]
  deadline = Faker::Time.backward(30, :morning)
  description = Faker::Hacker.say_something_smart
  Task.create!(title: title,
               priority: priority,
               deadline: deadline,
               description: description,
               active: false,
               group_id: Group.first.id,
               user_id: User.find(n).id)
end

for n in 1...20
  title = Faker::Company.bs
  priority = @priorities[rand(4)]
  deadline = Faker::Time.forward(30, :morning)
  description = Faker::Hacker.say_something_smart
  Task.create!(title: title,
               priority: priority,
               deadline: deadline,
               description: description,
               group_id: Group.second.id,
               user_id: User.find(n).id)


end

for n in 1...15
  title = Faker::Company.bs
  priority = @priorities[rand(4)]
  deadline = Faker::Time.forward(30, :morning)
  description = Faker::Hacker.say_something_smart
  Task.create!(title: title,
               priority: priority,
               deadline: deadline,
               description: description,
               group_id: Group.third.id,
               user_id: User.find(n).id)


end

####################### USER FOLLOWING ############################
for n in 1...20
  user = User.find(n)
  20.times do
    user2 = User.find(rand(40)+1)
    user.follow(user2) if user.id != user2.id
  end
end

####################### TASK FOLLOWING ############################
for n in 1...20
  user = User.find(n)
  20.times do
    task = Task.find(rand(50)+1)
    user.follow(task) if !user.following?(task)
  end
end

############################ COMMENTS #############################
for n in 1...20
  user = User.find(n)
  20.times do
    task = Task.find(rand(50)+1)
    content = Faker::Hacker.say_something_smart
    Comment.create!(user_id: user.id,
                    task_id: task.id,
                    content: content)
  end
end

############################# VOTES ###############################
for n in 1...20
  user = User.find(n)
  10.times do
    comment = Comment.find(rand(50)+1)
    comment.liked_by user
  end
  5.times do
    comment = Comment.find(rand(50)+1)
    comment.disliked_by user
  end
end
