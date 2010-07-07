class SessionController < ApplicationController
  
  def new
    #do nothing
    session[:change_openid] = true if params[:change_openid]
  end
  
  # This is the begining of a complicated process to log a user in with openid. 
  # :auth: is called to begin the openid process
  # :auth: redirects the user to their openid provider for authenication
  # openid provider redirects back to here with a response
  # :auth: parses the response and calls the block it's given (see :auth: for details)
  #
  # Once a valid openid is given we check to see if we are changing a user's openid
  # and call the approriate methods
  def create
    identity_url = params[:openid_identifier]
    auth(identity_url) do |status, url, reg|
      session[:openid] = url
      if session[:change_openid]
        change_openid(url)
      else
        start_login(url, reg["email"])
      end
    end
  end
  
  if ENV['RAILS_ENV']=='development'
    def dev_new
      return if request.get?
      u = User.find_by_name(params[:username])
      if u
        session[:user_id] = u.id
        successful_login(u)
      else
        flash[:error] = "User #{params[:username]} not found."
        redirect_to(:action => :dev_new)
      end
    end
  end

  def destroy
    session[:openid] = nil
    session[:user_id] = nil
    session[:real_user_id] = nil
    session[:change_openid] = nil
    redirect_back root_url
  end
  
  #REGSTRATION
  def transfer_registration
    
  end
  
  def register
  end
  
  def registration
    @user = User.find(params[:id])
    if @user.confirmed
      flash[:error] = "You are already registered."
      redirect_to root_url
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Could not find your registration id, try again?"
    redirect_to login_url(:register => "FileNotFound")
  end
  
  def update_registration
    @user = User.find(params[:id])
    p = params[:user].delete_if{|k,v| !["name", "email"].include? k.to_s }
    @user.send(:attributes=, 
      {
        :confirmed => true,
        :rank => ((User.count(:conditions => {:confirmed => true}) == 0) ? User::RANKS[:super_admin][:range].max : 0)
      }.update(p), false)
    if verify_recaptcha(:model => @user, :message => 'CAPTCHA failed to validate') && @user.save
      flash[:notice] = 'You have been successfully registered!'
      # NOTICE: This logs the user in, this code is duplicated to simplify login for the user
      create_new_session(@user)
      redirect_back(account_url)
    else
      render :action => "registration"
    end
  end
  

private
  # helper method for :create:
  #
  # Openid is a two step process. This method is called twice.
  #
  # The first step is to redirect the user to their provider. This method 
  # returns nil without executing the block it's given
  # 
  # The second step is to determine the provider's response. 
  # If successful this method executes the block it's given and returns
  # Otherwise it calls :failed_login: with an error message
  def auth(identity_url, &block) 
    reg = [ :email, 'http://schema.openid.net/contact/email']
    authenticate_with_open_id(identity_url, :required => reg) do |status, identity_url, registration|
      s = status.status
      case s
      when :successful
        #see docs for this method
        normalize_registration(registration)
        return yield(s, identity_url, registration)
      when :missing
        failed_login "Sorry, the OpenID server couldn't be found"
      when :invalid
        failed_login "Sorry, the OpenID given does not appear to be valid."
      when :canceled
        failed_login "OpenID verification was canceled"
      when :failed
        failed_login "Sorry, the OpenID verification failed"
      else
        failed_login "Login Failed: Unknown error in OpenID framework (Code returned was #{CGI::escapeHTML(s.inspect)})"
      end
      return false
    end
    #haven't finished the openid process yet!
    return nil
  end
  
  # Convert openid returned information into a common format since some providers
  # return data in a non-standard structure... LIKE GOOGLE
  def normalize_registration(registration)
    if registration
      if registration.has_key?('http://schema.openid.net/contact/email') && registration["email"].nil?
        registration["email"] = registration.delete('http://schema.openid.net/contact/email') 
      end
      if registration["email"].kind_of? Array
        registration["email"] = registration["email"][0]
      end
    end
  end

  # start the openid change process
  def change_openid(url)
    session[:change_openid] = nil
    # if logged out
    if !current_user
      flash[:alert] = "Attempt to change your openid has failed. Apparently you are logged out?"
      redirect_to root_url
    # if openid is assocated with an account
    elsif user = User.first(:conditions => {:openid_url => url}, :select => [:name])
      flash[:alert] = "Attempt to change your openid has failed. The openid you tried to switch to is already assocated with #{user.name}'s account."
      redirect_to account_url
    # if everything checks out
    else
      redirect_to openid_account_url
    end
  end
  
  # start the login or new account creation process
  def start_login(url, email)
    reg = {} if reg.nil?
    user = User.find_by_openid_url(url) || User.create!({:openid_url => url, :email => email})
    if user.confirmed? #user has been registered before or we are processing the openid
      successful_login(user)
    else
      complete_registration(user)
    end
  end
  
  def create_new_session(user)
    session[:user_id] = user.id if user.confirmed?
  end

  def successful_login(user)
    if current_user
      flash[:alert] = "You are now logged in as #{user.name}."
    else
      flash[:notice] =  "You are logged in as #{user.name}."
    end
    create_new_session(user)
    redirect_back account_url
  end
  
  def complete_registration(user)
    redirect_to registration_url(user.id)
  end

  def failed_login(message)
    session[:change_openid] = nil
    flash[:error] = message
    redirect_to(login_url)
  end

end
