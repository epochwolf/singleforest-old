class UserPagesController < ApplicationController
  before_filter :find_user, :except => :index
  
  def index
  end
  
  def show
  end
  
  def literature
    @literatures = @user.literatures.visible.paginate(:page => params[:page])
  end
  
  def collections
    @collections = @user.collections.visible.paginate(:page => params[:page])
  end
  
  def scratchpads
    @scratchpads = @user.scratchpads.visible.paginate(:page => params[:page])
  end
  
  def statistics
  end
  
  protected
  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render "user_not_found"
  end
end