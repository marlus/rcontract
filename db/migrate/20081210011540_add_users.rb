class AddUsers < ActiveRecord::Migration
  def self.up
    User.create(:username => 'admin', :password => 'qwe123', :name => 'Administrador', :email => 'admin@localhost', :group_id => 1)
    User.create(:username => 'coxa', :password => 'coxa', :name => 'Coxa', :email => 'coxa@localhost', :group_id => 2)
  end

  def self.down
  end
end
