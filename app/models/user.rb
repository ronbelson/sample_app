class User < ActiveRecord::Base

  has_many :microposts

  attr_accessible :name , :email

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email , :presence => true ,
                     :length => {:maximum => 50},
                     :format   => { :with => email_regex },
                     :uniqueness  => { :case_sensitive => false }

  validates :name ,  :presence => true



end
