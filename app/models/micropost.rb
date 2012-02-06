class Micropost < ActiveRecord::Base

  belongs_to :user

  validate :content,  :length =>  {:maximum => 140}

end
