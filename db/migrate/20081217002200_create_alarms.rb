class CreateAlarms < ActiveRecord::Migration
  def self.up
    create_table :alarms do |t|
      t.integer :alarm_period_warning_id
      t.integer :alarm_order_id
      t.string :warning_type

      t.timestamps
    end
  end

  def self.down
    drop_table :alarms
  end
end
