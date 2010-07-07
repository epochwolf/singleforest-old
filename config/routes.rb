ActionController::Routing::Routes.draw do |map|
  
#user pages
  map.resources :users, :only => [:index, :show], :member =>[:statistics, :literature, :collections, :scratchpads], :controller => "UserPages" do |u|
  end  
  
  map.resources :literatures, :as => :literature, :only => [:index, :show]

#forums
  map.resources :forum_categories, :as => :forums do |fmap|
    fmap.resources :forum_threads, :as => :threads, :member => {:sink => :post, :soft_delete => :post}
  end
  
  map.resources :comment_threads, :only => [:show], :as => "discussions" do |ctmap|
    ctmap.resources :comments, :as => "comments", :except => [:destroy]
  end


#account
  map.resource :account, :controller => "account", :namespace => "account/",
              :except => [:new, :create],
              :collection => {
                :user_page => :get,
                :openid => :get,
                :email => :get,
                :close => :get,
                :viewed_literature => :get
              } do |a2|
    a2.resources :literatures, :as => :literature
    a2.resources :notes
    a2.resources :collections
  end
  
#Login
  map.connect "login/dev", :controller => "session", :action => "dev_new"
  map.login "login", :controller => "session", :action => "new", :conditions => {:method => :get}
  map.login "login", :controller => "session", :action => "create", :conditions => {:method => :post}
  map.logout "logout", :controller => "session", :action => "destroy", :conditions => {:method => :delete}
#Register
  map.register "register", :controller => "session", :action => "register", :conditions => {:method => :get}
  map.registration "register/:id", :controller => "session", :action => "registration", :conditions => {:method => :get}
  map.connect "register/:id", :controller => "session", :action => "update_registration"

#admin
  map.masquerade "account/masquerade", :controller => "masquerade", :action => "show", :conditions => {:method => :get}
  map.connect "account/masquerade", :controller => "masquerade", :action => "new", :conditions => {:method => :post}
  map.connect "account/masquerade", :controller => "masquerade", :action => "destroy", :conditions => {:method => :delete}
  map.resources :pages
  map.resources :tags
  map.resources :flags
  
#debug
  map.debug "debug", :controller => "home", :action => "debug"

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
