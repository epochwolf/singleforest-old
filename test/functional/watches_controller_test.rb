require 'test_helper'

class WatchesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Watch.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Watch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Watch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to watch_url(assigns(:watch))
  end
  
  def test_edit
    get :edit, :id => Watch.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Watch.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Watch.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Watch.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Watch.first
    assert_redirected_to watch_url(assigns(:watch))
  end
  
  def test_destroy
    watch = Watch.first
    delete :destroy, :id => watch
    assert_redirected_to watches_url
    assert !Watch.exists?(watch.id)
  end
end
