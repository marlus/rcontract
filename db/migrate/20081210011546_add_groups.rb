class AddGroups < ActiveRecord::Migration
  def self.up
    group = Group.create(:name => 'Adminstradores')
  end

  def self.down
  end
end
