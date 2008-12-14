class AddGroups < ActiveRecord::Migration
  def self.up
    group = Group.create(:name => 'Administradores')
  end

  def self.down
  end
end
