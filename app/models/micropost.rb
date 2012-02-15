class Micropost < ActiveRecord::Base

  belongs_to :user
  
  attr_accessible :content
  
  validates :content,  
           :presence => true ,
           :length =>  {:within =>  1..140}
           
  validates :content,  :presence => true
           
  default_scope :order => 'microposts.created_at DESC'
                
end
