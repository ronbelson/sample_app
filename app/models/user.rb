class User < ActiveRecord::Base

  has_many :microposts

  attr_accessor :name , :email

  validates :name, :email

end
