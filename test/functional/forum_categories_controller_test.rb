require 'test_helper'

class ForumCategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => ForumCategory.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    ForumCategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    ForumCategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to forum_category_url(assigns(:forum_category))
  end
  
  def test_edit
    get :edit, :id => ForumCategory.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    ForumCategory.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ForumCategory.first
    assert_template 'edit'
  end
  
  def test_update_valid
    ForumCategory.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ForumCategory.first
    assert_redirected_to forum_category_url(assigns(:forum_category))
  end
  
  def test_destroy
    forum_category = ForumCategory.first
    delete :destroy, :id => forum_category
    assert_redirected_to forum_categories_url
    assert !ForumCategory.exists?(forum_category.id)
  end
end
