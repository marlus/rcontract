class ContractTypesController < ApplicationController

  before_filter :find_contract_type, :only => [ :show, :edit, :update, :destroy ]

  # GET /contract_types
  # GET /contract_types.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_contract_types.to_ext_json(:class => ContractType, :count => ContractType.count(options_from_search(ContractType))) }
    end
  end

  # GET /contract_types/1
  def show
    # show.html.erb
  end

  # GET /contract_types/new
  def new
    @contract_type = ContractType.new(params[:contract_type])
    # new.html.erb
  end

  # GET /contract_types/1/edit
  def edit
    # edit.html.erb
  end

  # POST /contract_types
  def create
    @contract_type = ContractType.new(params[:contract_type])

    respond_to do |format|
      if @contract_type.save
        notice = 'Tipo de Contrato inserido com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contract_types_path + "');" } }
      else
        format.ext_json { render :json => @contract_type.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /contract_types/1
  def update
    respond_to do |format|
      if @contract_type.update_attributes(params[:contract_type])
        notice = 'Tipo de Contrato alterada com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contract_types_path + "');" } }
      else
        format.ext_json { render :json => @contract_type.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /contract_types/1
  def destroy
    @contract_type.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_contract_type
      @contract_type = ContractType.find(params[:id])
    end
    
    def find_contract_types
      pagination_state = update_pagination_state_with_params!(ContractType)
      @contract_types = ContractType.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(ContractType)))
    end

end
