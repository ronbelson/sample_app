require 'digest'

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


  before_save :encript_password

  def has_password?(submitted_password)
    encripted_password == do_encript(password)
  end

  private

  def encript_password
    self.salt  = make_salt(password) unless has_password?(password)
    self.encripted_password =  do_encript(password)
  end

  def do_encript(string)
   secure_hash("#{string}")
  end

  def secure_hash(string)
      Digest::SHA2.hexdigest(string)
  end

  def make_salt(string)
    secure_hash("#{Time.now.utc}--#{string}")
  end
end
