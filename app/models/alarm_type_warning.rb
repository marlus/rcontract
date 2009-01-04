class AlarmTypeWarning < ActiveRecord::Base
  has_and_belongs_to_many :alarms
end
