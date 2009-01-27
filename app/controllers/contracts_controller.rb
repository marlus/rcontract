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
    debugger
    @contract_fields = ""
    params[:contract].each do |field|
      @contract_fields << field[0] + ": " + field[1] + ", "
    end
    
    params[:contract] = {:contract_category_id => params[:contract_category_id], :contract_type_id => '1', :contract => @contract_fields}
    @contract = Contract.new(params[:contract])

    respond_to do |format|
      if @contract.save
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
