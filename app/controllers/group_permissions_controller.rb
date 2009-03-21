class GroupPermissionsController < ApplicationController

  before_filter :find_group_permission, :only => [ :show, :edit, :update, :destroy ]

  # GET /group_permissions
  # GET /group_permissions.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_group_permissions.to_ext_json(:class => GroupPermission, :count => GroupPermission.count(options_from_search(GroupPermission)), :include => :group) }
    end
  end

  # GET /group_permissions/1
  def show
    # show.html.erb
  end

  # GET /group_permissions/new
  def new
    @group_permission = GroupPermission.new(params[:group_permission])
    # new.html.erb
  end

  # GET /group_permissions/1/edit
  def edit
    # edit.html.erb
  end

  # POST /group_permissions
  def create

    categories = params[:group_permission][:category_ids].split(',')
    params[:group_permission][:category_ids] = categories

    @group_permission = GroupPermission.new(params[:group_permission])

    respond_to do |format|
      if @group_permission.save
        notice = 'Acesso inserido com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + group_permissions_path + "');" } }
      else
        format.ext_json { render :json => @group_permission.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /group_permissions/1
  def update
    
    categories = params[:group_permission][:category_ids].split(',')
    params[:group_permission][:category_ids] = categories
    
    respond_to do |format|
      if @group_permission.update_attributes(params[:group_permission])
        notice = 'Acesso alterado com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + group_permissions_path + "');" } }
      else
        format.ext_json { render :json => @group_permission.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /group_permissions/1
  def destroy
    @group_permission.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_group_permission
      @group_permission = GroupPermission.find(params[:id])
    end
    
    def find_group_permissions
      pagination_state = update_pagination_state_with_params!(GroupPermission)
      @group_permissions = GroupPermission.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(GroupPermission)))
    end

end
