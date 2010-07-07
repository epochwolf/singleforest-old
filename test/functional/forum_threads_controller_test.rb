require 'test_helper'

class ForumThreadsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => ForumThread.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    ForumThread.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    ForumThread.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to forum_thread_url(assigns(:forum_thread))
  end
  
  def test_edit
    get :edit, :id => ForumThread.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    ForumThread.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ForumThread.first
    assert_template 'edit'
  end
  
  def test_update_valid
    ForumThread.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ForumThread.first
    assert_redirected_to forum_thread_url(assigns(:forum_thread))
  end
  
  def test_destroy
    forum_thread = ForumThread.first
    delete :destroy, :id => forum_thread
    assert_redirected_to forum_threads_url
    assert !ForumThread.exists?(forum_thread.id)
  end
end
