require 'test_helper'

class CollectionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Collection.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Collection.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Collection.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to collection_url(assigns(:collection))
  end
  
  def test_edit
    get :edit, :id => Collection.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Collection.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Collection.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Collection.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Collection.first
    assert_redirected_to collection_url(assigns(:collection))
  end
  
  def test_destroy
    collection = Collection.first
    delete :destroy, :id => collection
    assert_redirected_to collections_url
    assert !Collection.exists?(collection.id)
  end
end
