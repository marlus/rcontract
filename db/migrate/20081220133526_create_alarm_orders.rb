class CreateAlarmOrders < ActiveRecord::Migration
  def self.up
    create_table :alarm_orders do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :alarm_orders
  end
end
