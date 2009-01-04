class AddCategoryTypeContract < ActiveRecord::Migration
  def self.up
    #Categorias de contrato
    futebol_profissinal = ContractCategory.create(:name => 'Futebol Profissional')
    categoria_base = ContractCategory.create(:name => 'Categoria de Base')
    licenciamento = ContractCategory.create(:name => 'Licenciamento')
    rh = ContractCategory.create(:name => 'RH')
    outros = ContractCategory.create(:name => 'Outros')
    
    #Tipos de contrato
    #futebol = futebol_profissinal.find(:first)
    #futebol.create()
  end

  def self.down
  end
end
