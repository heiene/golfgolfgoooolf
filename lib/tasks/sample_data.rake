namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    adminuser = User.create!(name: "Oyvind Heiene",
                 email: "oyvindheiene@hotmail.com",
                 password: "aaaaaa",
                 password_confirmation: "aaaaaa")

    adminuser.toggle!(:admin)
    adminuser.save

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "aaaaaa"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
