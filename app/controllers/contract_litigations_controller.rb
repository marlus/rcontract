class ContractLitigationsController < ApplicationController

  before_filter :find_contract_litigation, :only => [ :show, :edit, :update, :destroy ]

  # GET /contract_litigations
  # GET /contract_litigations.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_contract_litigations.to_ext_json(:class => ContractLitigation, :count => ContractLitigation.count(options_from_search(ContractLitigation)), :include => [:contract]) }
    end
  end

  # GET /contract_litigations/1
  def show
    # show.html.erb
  end

  # GET /contract_litigations/new
  def new
    @contract_litigation = ContractLitigation.new(params[:contract_litigation])
    # new.html.erb
  end

  # GET /contract_litigations/1/edit
  def edit
    @contract_litigation = ContractLitigation.find(params[:id])
    # edit.html.erb
  end

  # POST /contract_litigations
  def create
    @contract_litigation = ContractLitigation.new(params[:contract_litigation])

    respond_to do |format|
      if @contract_litigation.save
        notice = 'Processo inserido com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
          page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contract_litigations_path + "');" } }
        
      else
        format.ext_json { render :json => @contract_litigation.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /contract_litigations/1
  def update
    respond_to do |format|
      if @contract_litigation.update_attributes(params[:contract_litigation])
        notice = 'Processo alterado com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contract_litigations_path + "');" } }
      else
        format.ext_json { render :json => @contract_litigation.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /contract_litigations/1
  def destroy
    @contract_litigation.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_contract_litigation
      @contract_litigation = ContractLitigation.find(params[:id])
    end
    
    def find_contract_litigations
      pagination_state = update_pagination_state_with_params!(ContractLitigation)
      @contract_litigations = ContractLitigation.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(ContractLitigation)))
    end

end
