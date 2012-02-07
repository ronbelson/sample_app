class User < ActiveRecord::Base

  has_many :microposts

  attr_accessor :password

  attr_accessible :name,
                  :email,
                  :password,
                  :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email , :presence => true ,
                     :length => {:maximum => 50},
                     :format   => { :with => email_regex },
                     :uniqueness  => { :case_sensitive => false }

  validates :name ,  :presence => true

  validates :password , :presence => true,
                        :confirmation => true,
                        :length => {:within =>  6..20}


  before_save :encripted_password

  #private

  def encripted_password
    self.encripted_password =  do_encript(password)
  end

  def do_encript(string)
    string
  end



end
