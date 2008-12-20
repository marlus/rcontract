class User < ActiveRecord::Base
  belongs_to :group
  
  validates_presence_of :username
  #validates_presence_of :password
  validates_presence_of :name
  validates_presence_of :group_id
end
