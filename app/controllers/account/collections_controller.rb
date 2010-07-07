class Account::CollectionsController < Account::AreaController
  
  def index
    @collections = @user.collections.all
  end
  
  def show
    @collection = @user.collections.find(params[:id])
  end
  
  def new
    @collection = @user.collections.build
  end
  
  def create
    @collection = @user.collections.build(params[:collection])
    if @collection.save
      flash[:notice] = "Successfully created collection."
      redirect_to collections_account_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @collection = @user.collections.find(params[:id])
  end
  
  def update
    @collection = @user.collections.find(params[:id])
    if @collection.update_attributes(params[:collection])
      flash[:notice] = "Successfully updated collection."
      redirect_to collections_account_url
    else
      render :action => 'edit'
    end
  end
  
  def order
  end
  
  def update_order
  end
  
  def destroy
    @collection = @user.collections.find(params[:id])
    @collection.destroy
    flash[:notice] = "Successfully destroyed collection."
    redirect_to collections_account_url
  end
end
