class CommentsController < ApplicationController
  before_filter :find_thread
  before_filter :check_locked, :only => [:new, :create]
  require_login :admin, :only => [:edit, :update, :destroy]
  
  def index
    @comments = @thread.comments.all
  end
  
  def show
    @comment = @thread.comments.find(params[:id])
  end
  
  def new
    @comment = @thread.comments.build
    @parent = @thread.comments.find(params[:parent])
    @comment.user_id = current_user.id
  end
  
  def create
    @comment = @thread.comments.build(params[:comment])
    @parent = @thread.comments.find(params[:parent]) if params[:parent]
    @comment.user_id = current_user.id
    
    # FIXME: special case for previewing, probably want to change this later
    unless params["commit"] == "Preview"
      saved = nil
      
      Comment.transaction do
        raise ActiveRecord::Rollback unless @comment.save
        saved = false
        raise ActiveRecord::Rollback unless @parent.nil? || @comment.move_to_child_of(@parent)
        saved = true
      end
    
      if saved 
        flash[:notice] = "Successfully created comments."
        redirect_back [@thread, @comment]
      else
        flash[:error] = "Error saving"
        render :action => :new
      end
    else
      render :action => :new
    end
  end
  
  def edit
    @comment = @thread.comments.find(params[:id])
  end
  
  def update
    @comment = @thread.comments.find(params[:id])
    @comment.deleted_at = (params[:comment][:deleted].to_i == 0 ? nil : DateTime.now)
    @comment.admin_note = params[:comment][:admin_note]
    if @comment.save
      flash[:notice] = "Successfully updated comments."
      redirect_back [@thread, @comment]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    # TODO: Audit this
    @comments = @thread.comments.find(params[:id])
    @comments.soft_delete = true
    if @comments.save
      flash[:notice] = "Successfully deleted comments."
    else
      flash[:alert] = "Failed to delete comments."
    end
    redirect_back [@thread, @comment]
  end
  
  protected
  def find_thread
    @thread = CommentThread.find(params[:comment_thread_id])
    if @thread.admin_only?
      throw403("This comment thread is hidden and you don't have permission to view it.") unless rank? :moderator
    end
  end
  
  def check_locked
    throw403("This comment thread is locked, you can't post to it.") if @thread.lock?
  end
end
