class AddPersonType < ActiveRecord::Migration
  def self.up
    personTypeFisica = PersonType.create(:name => "Fisica")
    personTypeJuridica = PersonType.create(:name => "Juridica")
  end

  def self.down
  end
end
