class TagsController < ApplicationController
  require_login :admin, :except => [:index, :show]
  
  def index
    #@tags = Tag.all
    @tags = Tag.all(
    :select => "tags.*, count(literatures_tags.literature_id) as literature_count",
    :joins => "LEFT OUTER JOIN literatures_tags on tags.id = literatures_tags.tag_id",
    :group => "tags.name"
    )
  end
  
  def show
    @tag = Tag.find(params[:id])
    @literatures = @tag.literatures.visible.paginate(:page => params[:page], :include => [:tags, :user])
  end
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      flash[:notice] = "Successfully created tag."
      redirect_to tags_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @tag = Tag.find(params[:id])
  end
  
  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(params[:tag])
      flash[:notice] = "Successfully updated tag."
      redirect_to tags_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash[:notice] = "Successfully destroyed tag."
    redirect_to tags_url
  end
end
