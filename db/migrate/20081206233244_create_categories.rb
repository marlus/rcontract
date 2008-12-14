class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.string :text
      t.string :link
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
