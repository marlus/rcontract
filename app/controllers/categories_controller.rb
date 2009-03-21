class CategoriesController < ApplicationController
  
  def index(id = params[:node])
    respond_to do |format|

      @categories = Array.new
      
      Category.find_children(id).each do |category|
        if(session[:permissions].include?(category.id))
          @categories.push(category)
        end
      end
      
      format.json { render :json => @categories }
              
    end
  end
  
  def list
    respond_to do |format|

      data = "{'rows': [" 
      Category.find(:all, :select => 'id,text', :conditions => ['parent_id = ?', 1]).each do |field|
        data << "{'id': '#{field.id}', 'text': '#{field.text}'},"
      end
      data << "]}"
          
      format.json { render :json => data }
    end
  end

  
  def list_from
    id = params[:id]
    respond_to do |format|
      data = "{'rows': [" 
      users_array = Array.new
      users = Category.find(:all, :select => 'categories.id, categories.text', :joins => :group_permissions, :conditions => ['categories_group_permissions.group_permission_id=?', id]).each do |field|
        users_array.push(field.id)
      end
      Category.find(:all, :select => 'id, text', :conditions => ['id not in (?) and parent_id = ?', users_array, 1]).each do |field|
        data << "{'id': '#{field.id}', 'text': '#{field.text}'},"
      end
      data << "]}"
      format.json { render :json => data }
    end
  end
  
  def list_to
    id = params[:id]
    respond_to do |format|
      data = "{'rows': [" 
      Category.find(:all, :select => 'categories.id, categories.text', :joins => :group_permissions, :conditions => ['categories_group_permissions.group_permission_id=?', id]).each do |field|
        data << "{'id': '#{field.id}', 'text': '#{field.text}'},"
      end
      data << "]}"
      format.json { render :json => data }
    end
  end
  
end
