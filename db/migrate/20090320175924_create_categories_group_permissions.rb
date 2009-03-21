class CreateCategoriesGroupPermissions < ActiveRecord::Migration
  def self.up
    create_table :categories_group_permissions do |t|
      t.integer :category_id 
      t.integer :group_permission_id
      t.timestamps
    end
    change_table :categories_group_permissions do |t|
      t.remove :id
    end
    
  end

  def self.down
    drop_table :categories_group_permissions
  end
end