module CurrentUser
  def self.included(mod)
    mod.helper_method :current_user, :rank?
    mod.before_filter :check_admin
  end
  
  # Grabs the currently logged in user
  # If show_real_id is true, it will return show if an admin is masquerading as
  # another user. (Nil if not, admin's user object otherwise)
  def current_user(show_real_id=false)
    if show_real_id
      session[:real_user_id] ? @current_real_user ||= User.find(session[:real_user_id]) : nil
    else
      session[:user_id] ? @current_user ||= User.find(session[:user_id]) : nil
      if @current_user 
        if @current_user.last_visited_at.nil? || (@current_user.last_visited_at < Date.today)
          @current_user.update_attribute(:last_visited_at, Date.today)  
        end
      end
      @current_user
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Error, you seemed to have been logged into a nonexistent account. You have been logged out."
    session[:user_id] = nil
    session[:real_user_id] = nil
  end
  
  # Determine if the logged in user has require ranks
  #
  # rank - if :owner, the user's rank isn't tested, just :user_id
  #        if :any we just require the user be logged and no banned or closed.
  # Options
  # User options, either one can be used, one of theses is required if rank = :owner
  # :user - if this is the logged in user, allow bypassing the required rank
  # :user_id - if the logged in user has this id, allow. 
  # :allow - accepts :closed, :banned, or :any
  #          :closed - allow closed accounts
  #          :banned - allow banned accounts
  #          :any - allow closed or banned accounts
  def rank?(rank=:any, options={}, &block)
    return false if current_user.nil?
    options = {
      :user_id => nil,
      :user => nil,
      :allow => nil,
    }.update options  
    #allow rank to be a user object.
    if rank.is_a? User
      options[:user] = rank
      rank = :owner
    end
    options[:user_id] = options[:user].id if options[:user]
    #allow block
    unless options[:allow] == :any
      return false if !options[:allow] == :closed && current_user.closed?
      return false if !options[:allow] == :banned && current_user.banned?
    end
    

    
    #test rank
    rank = :user if rank == :any
    rank = User::RANKS[rank][:range].send(:min) if User::RANKS.has_key? rank

    permit = if rank == :owner
      (options[:user_id] == current_user.id)
    elsif options[:user_id]
      (options[:user_id] == current_user.id) ||  (current_user.rank >= rank)
    else
      (current_user.rank >= rank)
    end
    yield if permit && block_given?
    permit
  end
  
  # instance method for self.require_login
  def require_login(rank=:user, allow=nil)
    if !current_user
      flash[:notice] = "You must login to continue."
      redirect_away  login_path
    elsif !rank?(rank, :allow => allow)
      render "error_pages/admin_required", :status => 403
    end
  end

  protected
  
  #prevent admins from modifying a user's account.
  def check_admin
    render "error_pages/masquerade", :layout => "plain", :status => 403 if current_user(true) && (!request.get? && controller_name != "masquerade")
  end
  
end