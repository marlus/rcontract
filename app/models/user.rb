class User < ActiveRecord::Base
  belongs_to :group
  has_and_belongs_to_many :group
  
  validates_presence_of :username
  validates_presence_of :password
  validates_presence_of :name
  validates_presence_of :group_id
end
