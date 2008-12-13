class AddUsers < ActiveRecord::Migration
  def self.up
    user = User.create(:username => 'psaux', :password => 'qwe123', :name => 'Psaux', :email => 'psaux1@gmail.com', :group_id => 1)
  end

  def self.down
  end
end
