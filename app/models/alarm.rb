class Alarm < ActiveRecord::Base
  belongs_to :contract
  belongs_to :alarm_order
  belongs_to :alarm_period_warning
  belongs_to :group
  has_and_belongs_to_many :alarm_type_warnings
  
  validates_presence_of :alarm_period_warning_id
  validates_presence_of :alarm_order_id
end
