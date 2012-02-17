Factory.define :user do |user|
  user.name                  "ron belson"
  user.email                 "test@me.com"
  user.password              "121212"
  user.password_confirmation "121212"
end

Factory.define :micropost do |micropost|
  micropost.content         "content"
  micropost.association      :user
end