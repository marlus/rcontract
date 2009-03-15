class AddAlarmPeriodWarning < ActiveRecord::Migration
  def self.up
    AlarmPeriodWarning.create(:name => '3 meses', :date_value => 92)
    AlarmPeriodWarning.create(:name => '6 meses', :date_value => 183)
    AlarmPeriodWarning.create(:name => '1 ano', :date_value => 365)
  end

  def self.down
  end
end
