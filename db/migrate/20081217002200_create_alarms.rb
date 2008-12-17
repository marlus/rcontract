class CreateAlarms < ActiveRecord::Migration
  def self.up
    create_table :alarms do |t|
      t.date :warning_date
      t.string :order
      t.string :warning_type

      t.timestamps
    end
  end

  def self.down
    drop_table :alarms
  end
end
