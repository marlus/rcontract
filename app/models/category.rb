class Category < ActiveRecord::Base
  
  has_and_belongs_to_many :group_permissions
  
  # For Rails 2.1: override default of include_root_in_json
  # (the Ext.tree.TreeLoader cannot use the additional nesting)
  Category.include_root_in_json = false if Category.respond_to?(:include_root_in_json)

  acts_as_nested_set

  def self.root_nodes
    find(:all, :conditions => 'parent_id IS NULL')
  end

  def self.find_children(start_id = nil)
    start_id.to_i == 0 ? root_nodes : find(start_id).direct_children
  end
  
  def leaf
    unknown? || children_count == 0
  end

  def to_json_with_leaf(options = {})
    self.to_json_without_leaf(options.merge(:methods => :leaf))
  end
  alias_method_chain :to_json, :leaf

end
