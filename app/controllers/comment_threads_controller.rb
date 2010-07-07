class CommentThreadsController < ApplicationController
  def show
    @thread = CommentThread.find(params[:id])
    @commentable = @thread.commentable
    
    case @commentable.class.name
    when "ForumThread" then 
      redirect_to [@commentable.category, @commentable]
    else 
      @comments = @thread.comments.all(:include => :_user, :order => :lft)
      render 
    end
  end
end