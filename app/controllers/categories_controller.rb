class CategoriesController < ApplicationController
  def index(id = params[:node])
    respond_to do |format|
      format.html # render static index.html.erb
      format.json { render :json => Category.find_children(id) }
    end
  end
end
