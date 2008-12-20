class Alarm < ActiveRecord::Base
  belongs_to :alarm_order
  belongs_to :alarm_period_warning
end
