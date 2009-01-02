class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.integer :contract_type_id
      t.string :data_fields
      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
