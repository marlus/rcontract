class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.integer :contract_category_id
      t.integer :contract_type_id
      t.string :contract
      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
