class AddAlarmOrder < ActiveRecord::Migration
  def self.up

    AlarmOrder.create(:name => 'Anterior vencimento')
    AlarmOrder.create(:name => 'Apos vencimento')
    
  end

  def self.down
  end
end
