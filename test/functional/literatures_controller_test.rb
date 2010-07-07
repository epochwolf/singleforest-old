require 'test_helper'

class LiteraturesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Literature.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Literature.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Literature.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to literature_url(assigns(:literature))
  end
  
  def test_edit
    get :edit, :id => Literature.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Literature.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Literature.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Literature.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Literature.first
    assert_redirected_to literature_url(assigns(:literature))
  end
  
  def test_destroy
    literature = Literature.first
    delete :destroy, :id => literature
    assert_redirected_to literatures_url
    assert !Literature.exists?(literature.id)
  end
end
