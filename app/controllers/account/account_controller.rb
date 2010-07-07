class Account::AccountController < Account::AreaController
  #prevent banned accounts from modifying their own things.
  require_login :any, :allow => :closed, :only => [:update]
  
  def show
    render :action => :dashboard
  end
  
  def user_page
    render :action => :biography
  end
  
  def openid
    @confirm = (session[:openid] != @user.openid_url)
    if @confirm
      @old_url = @user.openid_url
      @new_url = @user.openid_url = session[:openid]
    end
  end

  
  def email
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated your account."
      redirect_to account_url
    else
      if params[:user].has_key?(:website) || params[:user].has_key?(:biography)
        render :action => 'biography'
      elsif params[:user].has_key? :email
        render :action => 'email'
      elsif params[:user].has_key? :openid_url
        flash[:alert] = "Unknown error attempting to change your login provider."
        redirect_to account_url
      else
        flash[:alert] = "Unknown error updating your account."
        redirect_to account_url
      end
    end
  end
  
  def literature
    @literatures = @user.literatures.paginate(:page => params[:pages])
  end
  
  def collections
    @collections = @user.collections.all
  end
  
  def scratchpads
    @scratchpads = @user.scratchpads.paginate(:page => params[:pages])
  end
  
  def viewed_literature
    @literatures = Literature.all(
      :select => "literatures.*, literature_votes.vote, literatures.created_at as viewed_at",
      :joins => "LEFT OUTER JOIN literature_votes ON literatures.id = literature_votes.literature_id",
      :conditions => ["literature_votes.user_id = ?", current_user],
      :order => "literature_votes.created_at DESC"
    ).paginate(:page => params[:pages])
    #@literatures = @user.viewed_literatures
  end
  
  def messages
  end
  
  def close
  end
  
  def destroy
    if @user.update_attribute(:closed_at, DateTime.now)
      flash[:notice] = "Your account has been closed"
      redirect_to root_url
    else
      render :action => 'close_account'
    end
  end
  
end