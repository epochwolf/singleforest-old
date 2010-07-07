class Account::AreaController < ApplicationController
  require_login :any
  before_filter :find_user
  
  protected
  def find_user
    @user = current_user
  end
end