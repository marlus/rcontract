class AddAlarmTypeWarning < ActiveRecord::Migration
  def self.up
    AlarmTypeWarning.create(:name => 'E-mail')
    AlarmTypeWarning.create(:name => 'Celular')
    AlarmTypeWarning.create(:name => 'Página inicial')
  end

  def self.down
  end
end
