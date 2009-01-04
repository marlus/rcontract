class CreateAlarmTypeWarningsAlarms < ActiveRecord::Migration
  def self.up
    create_table :alarm_type_warnings_alarms do |t|
      t.integer :alarm_type_warning_id 
      t.integer :alarm_id
      t.timestamps
    end
    change_table :alarm_type_warnings_alarms do |t|
      t.remove :id
    end
  end

  def self.down
    drop_table :alarm_type_warnings_alarms
  end
end
