class AddItensCategories < ActiveRecord::Migration
  def self.up
    root = Category.create(:text => 'Menu')
    
    #Alarm
    root.add_child(alarme = Category.create(:text => 'Alarmes'))
    alarme.add_child(Category.create(:text => 'Inserir Alarme', :href => '/alarms/create'))
    alarme.add_child(Category.create(:text => 'Listar Alarmes', :href => '/alarms'))
    
    #Contract
    root.add_child(contrato = Category.create(:text => 'Contratos'))
    contrato.add_child(Category.create(:text => 'Inserir Contrato', :href => '/contracts/create'))
    contrato.add_child(Category.create(:text => 'Listar Contratos', :href => '/contracts'))
    
    #Report
    root.add_child(report = Category.create(:text => 'Relatorios'))
    report.add_child(Category.create(:text => 'Visualizar Relatorios', :href => '/reports'))
    
    #User
    root.add_child(user = Category.create(:text => 'Usuarios'))
    user.add_child(Category.create(:text => 'Inserir Usuario', :href => '/users/create'))
    user.add_child(Category.create(:text => 'Listar Usuarios', :href => '/users'))
    
    #Group
    root.add_child(group = Category.create(:text => 'Grupos de Usuarios'))
    group.add_child(Category.create(:text => 'Inserir Grupo', :href => '/groups/create'))
    group.add_child(Category.create(:text => 'Listar Grupos', :href => '/groups'))
    
    #Client
    root.add_child(client = Category.create(:text => 'Clientes/Fornecedores'))
    client.add_child(Category.create(:text => 'Inserir Cliente/Fornecedore', :href => '/clients/create'))
    client.add_child(Category.create(:text => 'Listar Clientes/Fornecedores', :href => '/clients'))
    
  end

  def self.down
  end
end