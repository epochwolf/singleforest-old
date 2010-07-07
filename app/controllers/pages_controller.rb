class PagesController < ApplicationController
  require_login :admin, :except => [:show]
  before_filter :find_page, :except => [:index, :new, :create]
  
  def index
    @pages = Page.visible.paginate(:select => [:title_slug], :page => params[:page])
  end
  
  def show
    
  end
  
  def new
    @page = Page.new(:title => params[:title])
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Successfully created page."
      redirect_to @page
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @page.update_attributes(params[:page])
      flash[:notice] = "Successfully updated page."
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to pages_url
  end
  
  protected
  def find_page
    title = params[:id].parameterize
    @page = Page.find_by_title_slug(title)
    unless @page
      raise ActiveRecord::RecordNotFound unless rank? :admin
      flash[:alert] = "Page not found"
      redirect_to new_page_path({:title => params[:id]})
    end
  end
end
