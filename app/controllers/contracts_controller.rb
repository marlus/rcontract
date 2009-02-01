class ContractsController < ApplicationController

  before_filter :find_contract, :only => [ :show, :edit, :update, :destroy ]

  # GET /contracts
  # GET /contracts.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_contracts.to_ext_json(:class => Contract, :count => Contract.count(options_from_search(Contract))) }
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
    # edit.html.erb
  end

  # POST /contracts
  def create
    @contract_fields = ""
    @total_size = params[:contract].length
    @file = nil
    @i = 0
    
    debugger
    
    params[:contract].each do |field|
      field_type = field[0].split("_")
      
      if(field_type[1] == 'arquivo')
        @file = field[1]
        field[1] = field[1].original_filename
      end
      
      @i = @i + 1
      if(@total_size != @i)
        @contract_fields << field_type[1] + "=>{" + field_type[0] + ": " + field[1] + "}|" 
      else
        @contract_fields << field_type[1] + "=>{" + field_type[0] + ": " + field[1] + "}"
      end
      
    end
    contract = {:contract_category_id => params[:contract_category].to_a[0][1], :contract_type_id => params[:contract_type_hidden], :contract => @contract_fields}
    @contract = Contract.new(contract)

    respond_to do |format|
      if @contract.save
        @contract.saveFile(@file)
        notice = 'Contract was successfully created.'
        format.ext_json { render(:update) {|page| page.alert notice 
          page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contracts_path + "');" } }
      else
        format.ext_json { render :json => @contract.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /contracts/1
  def update
    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        notice = 'Contract was successfully updated.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contracts_path + "');" } }
      else
        format.ext_json { render :json => @contract.to_ext_json(:success => false) }
      end
    end
  end
  
  def file
    # file.html.erb
  end
  
  def uploadFile
    
    debugger
    upload = params[:upload]
    name =  upload['datafile'].original_filename
    directory = CONTRACT_FILE_PATH
    
    debugger
    
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    
    render :text => "File has been uploaded successfully"
  end
  

  # DELETE /contracts/1
  def destroy
    @contract.destroy

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
