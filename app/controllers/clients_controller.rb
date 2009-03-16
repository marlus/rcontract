class ClientsController < ApplicationController

  before_filter :find_client, :only => [ :show, :edit, :update, :destroy ]

  # GET /clients
  # GET /clients.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_clients.to_ext_json(:class => Client, :count => Client.count(options_from_search(Client))) }
    end
  end

  # GET /clients/1
  def show
    # show.html.erb
  end

  # GET /clients/new
  def new
    @client = Client.new(params[:client])
    # new.html.erb
  end

  # GET /clients/1/edit
  def edit
    # edit.html.erb
  end

  # POST /clients
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        notice = 'Cliente/Fornecedor inserido com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + clients_path + "');" } }
      else
        format.ext_json { render :json => @client.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /clients/1
  def update
    respond_to do |format|
      if @client.update_attributes(params[:client])
        notice = 'Cliente/Fornecedor alterado com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + clients_path + "');" } }
      else
        format.ext_json { render :json => @client.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_client
      @client = Client.find(params[:id])
    end
    
    def find_clients
      pagination_state = update_pagination_state_with_params!(Client)
      @clients = Client.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(Client)))
    end

end
