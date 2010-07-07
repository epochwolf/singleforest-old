class Account::LiteraturesController < Account::AreaController
  
  def index
    @literatures = @user.literatures.paginate(:page => params[:page])
  end
  
  def show
    @literature = @user.literatures.find(params[:id])
    render :file => "literatures/show", :layout => "default"
  end
  
  def new
    @literature = @user.literatures.new
  end
  
  def step1
    @literature = @user.literatures.new
  end
  
  def step2
    @literature = @user.literatures.build(params[:literature])
    if @literature.valid?
      render :step2
    else
      flash[:alert] = "Errors prevented you from continuing to the next step."
      render :step1
    end
  end
  
  def step3
    @literature = @user.literatures.build(params[:literature])
    if @literature.valid?
      render :step3
    else
      flash[:alert] = "Errors prevented you from continuing to the next step."
      render :step2
    end
  end
  
  def create
    @literature = @user.literatures.build(params[:literature])
    @literature.title ||= "Untitled - #{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}"
    if @literature.save
      flash[:notice] = "Successfully created literature."
      redirect_to @literature
    else
      flash[:alert] = "Unable to save"
      render :action => 'new'
    end
  end
  
  def edit
    @literature = @user.literatures.find(params[:id])
  end
  
  def update
    @literature = @user.literatures.find(params[:id])
    if @literature.update_attributes(params[:literature])
      flash[:notice] = "Successfully updated literature."
      redirect_to @literature
    else
      flash[:alert] = "Unable to save"
      render :action => 'edit'
    end
  end
  
  def destroy
    @literature = @user.literatures.find(params[:id])
    @literature.destroy
    flash[:notice] = "Successfully destroyed literature."
    redirect_to literatures_url
  end
  
  # def vote #ajax
  #   @literature = Literature.visible.find(params[:id]) #only allow votes on visible stuff. 
  #   return render :text=>"permission error", :status => 500 unless current_user && request.xhr? && !(current_user.id == @literature.user_id)
  #   v = LiteratureVote.find_or_create_by_user_id_and_literature_id(current_user.id, @literature.id)
  #   v.vote = params[:literature_vote][:vote]
  #   if v.save
  #     render :text=>"saved"
  #   else 
  #     render :text=>"error: #{@vote.errors.full_messages.to_sentence}", :status => 500
  #   end
  # end
  
end
