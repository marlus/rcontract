class Client < ActiveRecord::Base
  belongs_to :person_type
  
  validates_presence_of :username
  
end
