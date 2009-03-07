class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.string :contract_identification
      t.integer :contract_category_id
      t.integer :contract_type_id
      t.integer :user_id
      t.string :contract
      t.date :contract_end_date
      t.string :file
      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
