class ContractsController < ApplicationController

  before_filter :find_contract, :only => [ :show, :edit, :update, :destroy ]

  # GET /contracts
  # GET /contracts.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_contracts.to_ext_json(:class => Contract, :count => Contract.count(options_from_search(Contract)), :include => [:contract_category, :contract_type]) }
    end
  end

  #GET /contract/list/1
  def list
    contract_type_id = params[:id]    
    respond_to do |format|
      format.json { render :json => Contract.find(:all, :order => 'id DESC', :select => 'id,contract_identification', :conditions => ['contract_type_id = ?', contract_type_id]) }
    end
  end

  # GET /contracts/1
  def show
    # show.html.erb
  end

  # GET /contracts/new
  def new
    @contract = Contract.new(params[:contract])
    # new.html.erb
  end

  # GET /contracts/1/edit
  def edit
    @contract = Contract.find(params[:id])
    @contract_values = Hash.new
    @contract_names = Array.new
    contract_fields = @contract['contract']
    fields = contract_fields.split('|')
    regexp_field_type = Regexp.new(/^[^=]+/)
    regexp_field_name = Regexp.new(/\{+[^:]+/)
    regexp_field_value = Regexp.new(/\:.[^\}]+/)
    fields.each do |row|
      field_type_reg = regexp_field_type.match(row)
      field_name_reg = regexp_field_name.match(row)
      field_value_reg = regexp_field_value.match(row)
      
      field_type = field_type_reg[0]
      field_name = field_name_reg[0]
      field_value = field_value_reg[0]
      
      field_name.slice!(0)
      field_value.slice!(0, 2)
      
      @contract_names << field_name
      @contract_values[field_name + "_value"] = field_value
      @contract_values[field_name + "_name"] = field_name
      @contract_values[field_name + "_type"] = field_type
    end
    #{}"caracter=>{CPF: 04220312919}|caracter=>{Nome: Marlus Cadanus da Costa}|caracter=>{RG: 87343740}"
    # edit.html.erb
  end

  # POST /contracts
  def create
    @contract_fields = ""
    @total_size = params[:contract].length
    @files = Array.new
    @i = 0

    params[:contract].each do |field|
      field_type = field[0].split("_")
    
      if(field_type[1] == 'arquivo')
        @files << field[1]
        field[1] = field[1].original_filename
      end
    
      @i = @i + 1
      if(@total_size != @i)
        @contract_fields << field_type[1] + "=>{" + field_type[0] + ": " + field[1] + "}|" 
      else
        @contract_fields << field_type[1] + "=>{" + field_type[0] + ": " + field[1] + "}"
      end    
    end

    date_to_format = params[:contract_end_date].split("/")
    contract_end_date = date_to_format[1] << "/" << date_to_format[0] << "/" <<date_to_format[2]

    contract = {:contract_identification => params[:contract_identification], :contract_category_id => params[:contract_category].to_a[0][1], :contract_type_id => params[:contract_type_hidden], :contract => @contract_fields, :user_id => session[:user_id], :file => params[:file].original_filename, :contract_end_date => contract_end_date}
    @contract = Contract.new(contract)

    respond_to do |format|
      if @contract.save
        @contract.saveFile(params[:file])
        @contract.saveFiles(@files)

        notice = 'Contrato inserido com sucesso.'
        format.html { render(:update) {|page| page.alert notice 
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contracts_path + "');" } }
      else
        format.ext_json { render :json => @contract.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /contracts/1
  def update
    @contract_fields = ""
    @total_size = params[:contract].length
    @files = Array.new
    @i = 0
    
    params[:contract].each do |field|
      field_type = field[0].split("_")
      
      if(field_type[1] == 'arquivo')
        @files << field[1]
        field[1] = field[1].original_filename
      end
      
      @i = @i + 1
      if(@total_size != @i)
        @contract_fields << field_type[1] + "=>{" + field_type[0] + ": " + field[1] + "}|" 
      else
        @contract_fields << field_type[1] + "=>{" + field_type[0] + ": " + field[1] + "}"
      end  
    end
    
    date_to_format = params[:contract_end_date].split("/")
    contract_end_date = date_to_format[1] << "/" << date_to_format[0] << "/" <<date_to_format[2]
    
    if(params[:file] == '')
      contract = {:contract_identification => params[:contract_identification], :contract_category_id => params[:contract_category].to_a[0][1], :contract_type_id => params[:contract_type_hidden], :contract => @contract_fields, :user_id => session[:user_id], :contract_end_date => contract_end_date}
    else
      contract = {:contract_identification => params[:contract_identification], :contract_category_id => params[:contract_category].to_a[0][1], :contract_type_id => params[:contract_type_hidden], :contract => @contract_fields, :user_id => session[:user_id], :file => params[:file].original_filename, :contract_end_date => contract_end_date}
    end
    
    respond_to do |format|
      if(params[:file] != '')
        @contract.destroyUniqueFile
        @contract.saveFile(params[:file])
      end
      
      if @contract.update_attributes(contract)        
        @contract.saveFiles(@files)
        notice = 'Contrato atualizado com sucesso.'
        format.html { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contracts_path + "');" } }
      else
        format.ext_json { render :json => @contract.to_ext_json(:success => false) }
      end
    end
  end
  
  # DELETE /contracts/1
  def destroy
    @contract.destroy
    @contract.destroyFile
    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_contract
      @contract = Contract.find(params[:id])
    end
    
    def find_contracts
      pagination_state = update_pagination_state_with_params!(Contract)
      @contracts = Contract.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(Contract)))
    end

end
