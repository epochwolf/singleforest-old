class ApplicationController < ActionController::Base
  include CurrentUser
  before_filter :link_return
  layout "default"
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  

  protected
  # Options
  # :only - passed to before_filter
  # :except - passed to before_filter
  # :allow - passed to ActionController#rank?
  def self.require_login(rank=:any, options={})
    allow = options.delete(:allow)
    before_filter options do |c| c.require_login(rank, allow) end
  end
  
  #stolen from: http://ethilien.net/archives/better-redirects-in-rails/
  # redirect somewhere that will eventually return back to here
  def redirect_away(*args)
    session[:original_uri] = request.request_uri
    redirect_to(*args)
  end
  
  #stolen from: http://ethilien.net/archives/better-redirects-in-rails/
  # returns the person to either the original url from a redirect_away or to a default url
  def redirect_back(*args)
    uri = session[:original_uri] || params[:return_uri]
    session[:original_uri] = nil
    if(uri && uri != request.request_uri)
      redirect_to uri
    else
      redirect_to(*args)
    end
  end
  
  private
  def link_return
    if params[:return_uri]
      session[:original_uri] = params[:return_uri]
    end
  end
  
  def throw403(error=nil)
    flash[:alert] = error if error
    render "error_pages/403", :status => 403
  end
  
  def throw404()
    #TODO, better message?
    raise ActiveRecord::RecordNotFound
  end
end
