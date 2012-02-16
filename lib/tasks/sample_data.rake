namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Ron Belson",
                 :email => "ronbelson@gmail.com",
                 :password => "121212",
                 :password_confirmation => "121212")
    admin.toggle!(:admin)
                 
    99.times do |n|
      name  = Faker::Name.name
      email = "ronbelson#{n+1}@gmail.com"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    
    50.times do
        User.find_by_email(admin.email).microposts.create!(:content => Faker::Lorem.sentence(5))  
    end
    
      users = User.all
      user  = users.first
      following = users[1..50]
      followers  = users[3..40]
      following.each { |followed| user.follow!(followed) }
      followers.each { |follower| follower.follow!(user) }

  end
end
