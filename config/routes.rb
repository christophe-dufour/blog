Rails.application.routes.draw do


  namespace :api, format: 'json' do
    resources :posts, as: :post_api
  end


  get '/admin' => 'admin#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'


  root to: 'posts#index', as: :root
  get '/page/:page', to: 'posts#index'
  get '/posts/:id', to: 'posts#show', as: 'post'
  get '/:date/:tags/:slug', to: 'posts#show'
end
