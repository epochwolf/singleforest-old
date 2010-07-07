class MasqueradeController < ApplicationController
  require_login :admin, :except => :destroy
  require_login :any, :allow => :any, :only => :destroy
  
  def show
    render "account/switch"
  end
  
  #post
  def new
    @user = User.find(params[:user_id])
    session[:real_user_id] = session[:user_id]
    session[:user_id] = @user.id
    if(session[:real_user_id] == session[:user_id])
      flash[:notice] = "You are masquerading as yourself? Okay... have fun with that."
    else
      flash[:notice] = "You are masquerading as #{@user.name}."
    end
    redirect_to account_url
  rescue
    flash.now[:alert] ="User with id #{params[:user_id].to_i} not found."
    render "account/switch"
  end
   
  #delete
  def destroy
    if session[:user_id]
      session[:user_id] = session[:real_user_id]
      session[:real_user_id] = nil
      flash[:notice] = "You are no longer masquerading."
      redirect_to account_url
    else
      head(500) # TODO: add better error later
    end
  end
end