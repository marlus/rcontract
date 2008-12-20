class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.date :date_start
      t.date :date_end
      t.decimal :value
      t.string :description
      t.integer :person_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
