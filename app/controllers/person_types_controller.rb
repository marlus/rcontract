class PersonTypesController < ApplicationController

  before_filter :find_person_type, :only => [ :show, :edit, :update, :destroy ]

  # GET /person_types
  # GET /person_types.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_person_types.to_ext_json(:class => PersonType, :count => PersonType.count(options_from_search(PersonType))) }
    end
  end

  # GET /person_types/1
  def show
    # show.html.erb
  end

  # GET /person_types/new
  def new
    @person_type = PersonType.new(params[:person_type])
    # new.html.erb
  end

  # GET /person_types/1/edit
  def edit
    # edit.html.erb
  end

  # POST /person_types
  def create
    @person_type = PersonType.new(params[:person_type])

    respond_to do |format|
      if @person_type.save
        notice = 'PersonType was successfully created.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + person_types_path + "');" } }
      else
        format.ext_json { render :json => @person_type.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /person_types/1
  def update
    respond_to do |format|
      if @person_type.update_attributes(params[:person_type])
        notice = 'PersonType was successfully updated.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + person_types_path + "');" } }
      else
        format.ext_json { render :json => @person_type.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /person_types/1
  def destroy
    @person_type.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_person_type
      @person_type = PersonType.find(params[:id])
    end
    
    def find_person_types
      pagination_state = update_pagination_state_with_params!(PersonType)
      @person_types = PersonType.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(PersonType)))
    end

end
