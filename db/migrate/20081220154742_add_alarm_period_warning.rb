class AddAlarmPeriodWarning < ActiveRecord::Migration
  def self.up
    AlarmPeriodWarning.create(:name => '1 dia')
    AlarmPeriodWarning.create(:name => '5 dias')
    AlarmPeriodWarning.create(:name => '10 dias')
    AlarmPeriodWarning.create(:name => '15 dias')
    AlarmPeriodWarning.create(:name => '20 dias')
    AlarmPeriodWarning.create(:name => '30 dias')
  end

  def self.down
  end
end
