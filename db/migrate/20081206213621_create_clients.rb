class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.integer :person_type_id
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
