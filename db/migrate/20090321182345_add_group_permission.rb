class AddGroupPermission < ActiveRecord::Migration
  def self.up
    GroupPermission.create(:group_id => 1, :category_ids => [2, 5, 14, 16, 19, 22, 25])
    GroupPermission.create(:group_id => 2, :category_ids => [2, 14])
  end

  def self.down
  end
end
