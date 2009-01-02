class CreateContractCategories < ActiveRecord::Migration
  def self.up
    create_table :contract_categories do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :contract_categories
  end
end
