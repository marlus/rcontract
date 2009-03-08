class AlarmsController < ApplicationController

  before_filter :find_alarm, :only => [ :show, :edit, :update, :destroy ]

  # GET /alarms
  # GET /alarms.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_alarms.to_ext_json(:class => Alarm, :count => Alarm.count(options_from_search(Alarm)), :include => [:alarm_order, :alarm_period_warning, :contract]) }
    end
  end

  # GET /alarms/1
  def show
    # show.html.erb
  end

  # GET /alarms/new
  def new
    @alarm = Alarm.new(params[:alarm])
    # new.html.erb
  end

  # GET /alarms/1/edit
  def edit
    # edit.html.erb
  end

  # POST /alarms
  def create
    @alarm = Alarm.new(params[:alarm])

    respond_to do |format|
      if @alarm.save
        notice = 'Alarme inserido com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + alarms_path + "');" } }
      else
        format.ext_json { render :json => @alarm.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /alarms/1
  def update
    params[:alarm][:alarm_type_warning_ids] ||= []
    respond_to do |format|
      if @alarm.update_attributes(params[:alarm])
        notice = 'Alarme alterado com sucesso.'
        format.ext_json { render(:update) {|page| page.alert notice
           page << "parent.updateTab('" + params[:tabId] + "', '" + params[:tabTitle] + "', '" + alarms_path + "');" } }
      else
        format.ext_json { render :json => @alarm.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /alarms/1
  def destroy
    @alarm.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_alarm
      @alarm = Alarm.find(params[:id])
    end
    
    def find_alarms
      pagination_state = update_pagination_state_with_params!(Alarm)
      @alarms = Alarm.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(Alarm)))
    end
end
