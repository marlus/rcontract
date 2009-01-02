class Alarm < ActiveRecord::Base
  belongs_to :alarm_order
  belongs_to :alarm_period_warning
  
  validates_presence_of :alarm_period_warning_id
  validates_presence_of :alarm_order_id
  validates_presence_of :warning_type
end
