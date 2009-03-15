class CreateContractLitigations < ActiveRecord::Migration
  def self.up
    create_table :contract_litigations do |t|
      t.integer :contract_id
      t.string :description
      t.string :number

      t.timestamps
    end
  end

  def self.down
    drop_table :contract_litigations
  end
end
