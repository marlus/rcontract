class CreateContractTypes < ActiveRecord::Migration
  def self.up
    create_table :contract_types do |t|
      t.string :document
      t.string :fields
      t.integer :contract_category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contract_types
  end
end
