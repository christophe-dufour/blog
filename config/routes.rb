Rails.application.routes.draw do


  namespace :api, format: 'json' do
    resources :posts, as: :post_api do
      member do
        post :publish, action: :publish
        delete :publish, action: :unpublish
      end
    end
  end


  root to: 'posts#index', as: :root

  constraints format: :js do
    get '/posts/:id/view', to: 'posts#view', as: 'view_post'
  end


  constraints format: 'html' do
    get '/session' => 'sessions#index', as: 'session'
    get '/admin' => 'admin#index', as: 'admin'
    get 'admin/s3_access_token' => 'admin#s3_access_token', as: 's3_access_token'
    get '/auth/:provider/callback' => 'sessions#create'
    get '/signin' => 'sessions#new', :as => :signin
    get '/signout' => 'sessions#destroy', :as => :signout
    get '/auth/failure' => 'sessions#failure'


    get '/page/:page', to: 'posts#index'
    get '/posts/:id', to: 'posts#show', as: 'post'
    get '/:date/:tags/:slug', to: 'posts#show'
  end


end
