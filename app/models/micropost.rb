class Micropost < ActiveRecord::Base

  belong_to :user

  validate :content,  :length =>  {:maximum => 140}

end
