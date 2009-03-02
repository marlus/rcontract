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

  #GET /contract_types/list_types/1
  def list_types
    contract_category_id = params[:id]    
    respond_to do |format|
      format.json { render :json => ContractType.find(:all, :order => 'id DESC', :select => 'id,document', :conditions => ['contract_category_id = ?', contract_category_id]) }
    end
  end

  #GET /contract_types/list_fields/1
  def list_fields
    id = params[:id]    
    respond_to do |format|
      format.json { render :json => ContractType.find(:all, :order => 'id DESC',:conditions => ['id = ?', id]) }
    end
  end

  def list_grid_fields
    id = params[:id]    
    respond_to do |format|
      json_response = "{'rows': ["
      contractType = ContractType.find(:first, :select=>'fields', :conditions=>['id = ?', id])

      fields = contractType.fields.split(',')
      fields.each do |field|
        field_properties = field.split(':')
        field_name = field_properties[0]
        field_type = field_properties[1]
        field_required = field_properties[2]
        if fields.last != field
          json_response << "{'nome_campo': '" + field_name + "', 'tipo_campo': '" + field_type + "', 'obrigatorio': " + field_required + "},"
        else
          json_response << "{'nome_campo': '" + field_name + "', 'tipo_campo': '" + field_type + "', 'obrigatorio': " + field_required + "}"
        end
      end
      json_response << "]}"
      format.json { render :json => json_response }
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
    @contract_type = ContractType.find(params[:id])
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
        notice = 'Tipo de Contrato alterado com sucesso.'
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
