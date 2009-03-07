class ReportController < ApplicationController

  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_users.to_ext_json(:class => User, :count => User.count(options_from_search(User))) }
    end
  end
end
