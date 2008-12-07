class HomeController < ApplicationController
  def index
    #@cats = render_component :controller => "categories"
    respond_to do |format|
      format.html
    end
  end
  
  def secure?
    true
  end
end
