class AddItensCategories < ActiveRecord::Migration
  def self.up
    root = Category.create(:text => 'Menu')
    
    #Alarm
    root.add_child(alarme = Category.create(:text => 'Alarmes'))
    alarme.add_child(Category.create(:text => 'Inserir Alarme', :link => '/alarms/new'))
    alarme.add_child(Category.create(:text => 'Listar Alarmes', :link => '/alarms'))
    
    #Contract
    root.add_child(contrato = Category.create(:text => 'Contratos'))
    contrato.add_child(Category.create(:text => 'Inserir Categoria de Contrato', :link => '/contract_categories/new'))
    contrato.add_child(Category.create(:text => 'Listar Categoria de Contratos', :link => '/contract_categories'))
    contrato.add_child(Category.create(:text => 'Inserir Tipo de Contrato', :link => '/contract_types/new'))
    contrato.add_child(Category.create(:text => 'Listar Tipo de Contratos', :link => '/contract_types'))    
    contrato.add_child(Category.create(:text => 'Inserir Contrato', :link => '/contracts/new'))
    contrato.add_child(Category.create(:text => 'Listar Contratos', :link => '/contracts'))
    
    #Report
    root.add_child(report = Category.create(:text => 'Relatorios'))
    report.add_child(Category.create(:text => 'Visualizar Relatorios', :link => '/reports'))
    
    #User
    root.add_child(user = Category.create(:text => 'Usuarios'))
    user.add_child(Category.create(:text => 'Inserir Usuario', :link => '/users/new'))
    user.add_child(Category.create(:text => 'Listar Usuarios', :link => '/users'))
    
    #Group
    root.add_child(group = Category.create(:text => 'Grupos de Usuarios'))
    group.add_child(Category.create(:text => 'Inserir Grupo', :link => '/groups/new'))
    group.add_child(Category.create(:text => 'Listar Grupos', :link => '/groups'))
    
    #Client
    root.add_child(client = Category.create(:text => 'Clientes/Fornecedores'))
    client.add_child(Category.create(:text => 'Inserir Cliente/Fornecedore', :link => '/clients/new'))
    client.add_child(Category.create(:text => 'Listar Clientes/Fornecedores', :link => '/clients'))
    
  end

  def self.down
  end
end