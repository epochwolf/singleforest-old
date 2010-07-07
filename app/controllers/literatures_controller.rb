class LiteraturesController < ApplicationController
  def index
    @literatures = Literature.finished.paginate(:page => params[:page])
  end
  
  def show
    @literature = Literature.finished.find(params[:id])
  end
  
  protected
  def method_name
    
  end
end