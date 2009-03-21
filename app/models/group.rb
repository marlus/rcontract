class Group < ActiveRecord::Base
  has_many :users
  has_many :alarms
  has_many :group_permissions
end
