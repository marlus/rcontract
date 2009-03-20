class CreateGroupsUsers < ActiveRecord::Migration
  def self.up
    create_table :groups_users do |t|
      t.integer :user_id 
      t.integer :group_id
      t.timestamps
    end
    change_table :groups_users do |t|
      t.remove :id
    end
    
  end

  def self.down
    drop_table :groups_users
  end
end