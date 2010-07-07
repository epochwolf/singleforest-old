class ForumThreadsController < ApplicationController
  before_filter :find_category
  require_login :user, :except => [:show, :update, :edit, :delete]
  require_login :moderator, :only => [:update, :edit, :delete]
  
  def index
    #need to redirect /forums/*/threads to /forums/*
    redirect_to(forum_category_path(params[:forum_category_id])) if params[:id].nil?
  end
  
  def show
    @forum_thread = @category.threads.find(params[:id], :include => :_user)
  end
  
  def new
    @forum_thread = @category.threads.new
    @forum_thread.user_id = current_user.id
  end
  
  def create
    @forum_thread = @category.threads.build(params[:forum_thread])
    @forum_thread.user_id = current_user.id
    if @forum_thread.save
      flash[:notice] = "Successfully created forum thread."
      redirect_to [@category, @forum_thread]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum_thread = @category.threads.find(params[:id])
  end
  
  def update
    @forum_thread = @category.threads.find(params[:id])
    @forum_thread.send(:attributes=, params[:forum_thread], false)
    if @forum_thread.save
      flash[:notice] = "Successfully updated forum thread."
      redirect_to [@category, @forum_thread]
    else
      render :action => 'edit'
    end
  end
  
  def sink
    @forum_thread = @category.threads.find(params[:id])
    @forum_thread.toggle!(:sunk)
    if @forum_thread.sunk?
      flash[:notice] = "Thread has been sunk"
    else
      flash[:notice] = "Thread has been unsunk"
    end
    redirect_to [@category, @forum_thread]
  end
  
  def soft_delete
    @forum_thread = @category.threads.find(params[:id])
    @forum_thread.toggle!(:deleted)
    if @forum_thread.deleted?
      flash[:notice] = "Thread has been soft deleted"
    else
      flash[:notice] = "Thread has been undeleted"
    end
    redirect_to [@category, @forum_thread]
  end
  
  def destroy
    @forum_thread = @category.threads.find(params[:id])
    @forum_thread.destroy
    flash[:notice] = "Successfully destroyed forum thread."
    redirect_to @category
  end
  
  protected
  def find_category
    @category = ForumCategory.find(params[:forum_category_id])  
    if @category.admin_only? && !rank?(:moderator)
      render403("Threads in this forum category are hidden and you don't have permission to view it.")
    end
    # TODO: Decide if I need to catch this exception.
  end
end
