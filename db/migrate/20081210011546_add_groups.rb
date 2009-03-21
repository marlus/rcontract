class AddGroups < ActiveRecord::Migration
  def self.up
    Group.create(:name => 'Administradores')
    Group.create(:name => 'Usuários')
  end

  def self.down
  end
end
