class ForumCategoriesController < ApplicationController
  require_login :admin, :except => [:index, :show]
  before_filter :check_admin
  
  def index
    @forums = if rank? :moderator
       Forum.all(:include => {:categories => :top_threads})
    else
      Forum.visible.all(:include => {:categories => :top_threads})
    end
  end
  
  def show
    @forum_category = ForumCategory.find(params[:id])
    if @forum_category.admin_only && !rank?(:moderator)
      render403("This forum category is hidden and you don't have permission to view it.") 
    else
      @threads = @forum_category.threads.paginate(:page => params[:page])
    end
  end
  
  def new
    @forum_category = ForumCategory.new(:forum_id => params[:forum])
  end
  
  def create
    @forum_category = ForumCategory.new(params[:forum_category])
    if @forum_category.save
      flash[:notice] = "Successfully created forum category."
      redirect_to forum_categories_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum_category = ForumCategory.find(params[:id])
  end
  
  def update
    @forum_category = ForumCategory.find(params[:id])
    if @forum_category.update_attributes(params[:forum_category])
      flash[:notice] = "Successfully updated forum category."
      redirect_to forum_categories_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @forum_category = ForumCategory.find(params[:id])
    @forum_category.destroy
    flash[:notice] = "Successfully destroyed forum category."
    redirect_to forum_categories_url
  end
end
