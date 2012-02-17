require 'digest'

class User < ActiveRecord::Base

  has_many :microposts , :dependent => :destroy
  
  has_many :relationships, :dependent => :destroy,
                            :foreign_key => "follower_id"
  has_many :reverse_relationships, :dependent => :destroy,
                                    :foreign_key => "followed_id",
                                    :class_name => "Relationship"
  has_many :following, :through => :relationships, :source => :followed
  has_many :followers, :through => :reverse_relationships,
                        :source  => :follower
  

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
    encripted_password == encrypt(submitted_password)
  end

  def self.authenticate(email,password)
    user = self.find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(password)
  end

  def self.authenticate_with_salt(id,cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
   def feed
     Micropost.from_users_followed_by(self)
   end
  
  def following?(followed)
     relationships.find_by_followed_id(followed)
   end

   def follow!(followed)
     relationships.create!(:followed_id => followed.id)
   end
    
   def unfollow!(followed)
       relationships.find_by_followed_id(followed).destroy
   end
   
  private

  def encript_password
    self.salt  = make_salt(password) if self.new_record?
    self.encripted_password = encrypt(password)
  end

  def encrypt(string)
   secure_hash("#{salt}--#{string}")
  end

  def secure_hash(string)
      Digest::SHA2.hexdigest(string)
  end

  def make_salt(string)
    secure_hash("#{Time.now.utc}--#{string}")
  end
  
 
  
  
end
