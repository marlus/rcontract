class UsersController < ApplicationController

  before_filter :find_user, :only => [ :show, :edit, :update, :destroy ]

  # GET /users
  # GET /users.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_users.to_ext_json(:class => User, :count => User.count(options_from_search(User))) }
    end
  end

  def list_users
    respond_to do |format|
      data = "{'rows': [" 
      User.find(:all, :select => 'id,username').each do |field|
        data << "{'id': '#{field.id}', 'username': '#{field.username}'},"
      end
      data << "]}"
      format.json { render :json => data }
    end
  end

  # GET /users/1
  def show
    # show.html.erb
  end

  # GET /users/new
  def new
    @user = User.new(params[:user])
    # new.html.erb
  end

  # GET /users/1/edit
  def edit
    # edit.html.erb
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        notice = 'Usuário inserido com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + users_path + "');" } }
      else
        format.ext_json { render :json => @user.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /users/1
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        notice = 'Usuário alterado com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + users_path + "');" } }
      else
        format.ext_json { render :json => @user.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_user
      @user = User.find(params[:id])
    end
    
    def find_users
      pagination_state = update_pagination_state_with_params!(User)
      @users = User.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(User)))
    end

    def secure?
      true
    end

end
