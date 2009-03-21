class LoginController < ApplicationController
  def index
    render :action => 'login'
  end
  
  def login
  end
  
  def do_login
      #render :text => '{ success: true}'
      username = params[:username]
      password = params[:password]
      
      @user = User.find(:first, :conditions => [ "username = ?", username])
      
      if @user.nil? || @user.id.nil? || @user.username.nil?
        #redirect_to :action => "login"
        #flash[:notice] = 'Usuário ou senha incorretos'
        render :text => '{ success: false, errors: { reason: "Usuario ou senha incorretos" }}'
      else 
          if @user.password == password
            session[:user_id] = @user.id
            session[:group_id] = @user.group_id
            session[:name] = @user.name
            session[:permissions] = Array.new
            session[:permissions].push(1)
            
            GroupPermission.find(:first, :conditions => ['group_id = ?', @user.group_id]).categories.each do |categories_group|
              session[:permissions].push(categories_group.id)
              
              Category.find_children(categories_group.id).each do |category|
                session[:permissions].push(category.id)
              end
            end
            
            
            render :text => '{ success: true}'
            #redirect_to :controller => "users", :action => "index"
            #puts "sucess"
            #format.json { render :json => 'sucess: true' }
          else
            #redirect_to :action => "login"
            render :text => '{ success: false, errors: { reason: "Usuario ou senha incorretos" }}'
            flash[:notice] = 'Usuário ou senha incorretos'
          end
      end
  end
  
  def do_logout
      session[:user_id] = nil
    redirect_to :action => "login"
  end
end