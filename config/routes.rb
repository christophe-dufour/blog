Rails.application.routes.draw do


  scope module: 'admin' do
    get '/auth/:provider/callback' => 'sessions#create'
    get '/signin' => 'sessions#new', :as => :signin
    get '/signout' => 'sessions#destroy', :as => :signout
    get '/auth/failure' => 'sessions#failure'
  end


  root to: 'posts#index'
  get '/page/:page', to: 'posts#index'
  get '/posts/:id', to: 'posts#show', as: 'post'
  get '/:date/:tags/:slug', to: 'posts#show'
end
