class CreateAlarmTypeWarnings < ActiveRecord::Migration
  def self.up
    create_table :alarm_type_warnings do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :alarm_type_warnings
  end
end
