class GroupsController < ApplicationController

  before_filter :find_group, :only => [ :show, :edit, :update, :destroy ]

  # GET /groups
  # GET /groups.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_groups.to_ext_json(:class => Group, :count => Group.count(options_from_search(Group))) }
    end
  end

  # GET /groups/1
  def show
    # show.html.erb
  end

  # GET /groups/new
  def new
    @group = Group.new(params[:group])
    # new.html.erb
  end

  # GET /groups/1/edit
  def edit
    # edit.html.erb
  end

  # POST /groups
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        notice = 'Grupo inserido com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + groups_path + "');" } }
      else
        format.ext_json { render :json => @group.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /groups/1
  def update
    
    users = params[:group][:user_ids].split(',')
    params[:group][:user_ids] = users
    
    respond_to do |format|
      if @group.update_attributes(params[:group])
        notice = 'Grupo alterado com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + groups_path + "');" } }
      else
        format.ext_json { render :json => @group.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_group
      @group = Group.find(params[:id])
    end
    
    def find_groups
      pagination_state = update_pagination_state_with_params!(Group)
      @groups = Group.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(Group)))
    end

end
