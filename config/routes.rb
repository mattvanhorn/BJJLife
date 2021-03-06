Bjjlife::Application.routes.draw do
  resources :subscriptions, :only => [:create] do
    get 'thanks', :on => :collection
  end
  root :to => 'subscriptions#new'
  mount Split::Dashboard, :at => 'split'

  namespace :admin do
    match '/' => 'home#index'
    resources :subscriptions, :only => [:index]
    resources :videos, :only => [:index, :new, :create, :destroy]
    resources :academies, :only => [:index] do
      member do
        put 'publish'
      end
    end
    resources :products, :only => [:index, :new, :create, :edit, :update]
    resources :categories, :only => [:index, :new, :create, :destroy]
  end

  resources :videos, :only => [:index, :new, :create] do
    member do
      put 'upvote'
      put 'downvote'
    end
  end
  resources :academies, :only => [:index]
  resources :academy_listings, :only => [:create], :path => '/academies'
  get '/academies/new', :to => 'academy_listings#new', :as => :new_academy

  resources :blogs, :only => [:show]
  resources :posts, :only => [:new, :create, :show] do
    resources :comments, :only => [:create]
  end

  resource :journal, :only => [:new, :show, :create] do
    resources :entries, :controller => :journal_entries, :only => [:new, :create, :show]
  end

  match "/sign_up", :to => "accounts#new", :as => :sign_up
  match '/auth/:provider/callback', :to => 'sessions#create'
  match 'auth/fail', :to => 'sessions#failure'

  resource :account, :only => [:edit, :update, :show]

  match "/auth/identity" => "sessions#new"
  match '/sign_in',  to: 'sessions#new',      :as => :sign_in
  match '/sign_out', to: 'sessions#destroy',  :as => :sign_out

  mount RolloutUi::Engine, :at => "/rollout"

  resources :products, :only => [:index, :show] do
    resources :orders, :only => [:new, :create]
  end
  resources :orders, :only => [:show]
  match 'academies/search' => 'academies#search', :as => :academy_searches

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
