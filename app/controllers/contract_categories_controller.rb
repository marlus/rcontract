class ContractCategoriesController < ApplicationController

  before_filter :find_contract_category, :only => [ :show, :edit, :update, :destroy ]

  # GET /contract_categories
  # GET /contract_categories.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_contract_categories.to_ext_json(:class => ContractCategory, :count => ContractCategory.count(options_from_search(ContractCategory))) }
    end
  end

  # GET /contract_categories/1
  def show
    # show.html.erb
  end

  # GET /contract_categories/new
  def new
    @contract_category = ContractCategory.new(params[:contract_category])
    # new.html.erb
  end

  # GET /contract_categories/1/edit
  def edit
    # edit.html.erb
  end

  # POST /contract_categories
  def create
    @contract_category = ContractCategory.new(params[:contract_category])

    respond_to do |format|
      if @contract_category.save
        notice = 'Categoria de Contrato inserida com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contract_categories_path + "');" } }
      else
        format.ext_json { render :json => @contract_category.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /contract_categories/1
  def update
    respond_to do |format|
      if @contract_category.update_attributes(params[:contract_category])
        notice = 'Categoria de Contrato alterada com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + contract_categories_path + "');" } }
      else
        format.ext_json { render :json => @contract_category.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /contract_categories/1
  def destroy
    @contract_category.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_contract_category
      @contract_category = ContractCategory.find(params[:id])
    end
    
    def find_contract_categories
      pagination_state = update_pagination_state_with_params!(ContractCategory)
      @contract_categories = ContractCategory.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(ContractCategory)))
    end

end
