Rails.application.routes.draw do



  resources :controls
  resources :tracks
  devise_for :users
  get 'home/index'

  resources :treasures
  get 'api/get_users'       => 'service#get_users'
  post 'api/create_player'  => 'service#create_player'
  post 'api/add_pos'        => 'service#add_pos'

  #get 'ping'        => 'service#ping'
  get '/api/ping_android'           => 'service#ping_android'
  get '/api/get_treasures_within'   => 'service#get_treasures_within'
  get '/players'    => 'player#index'
  get '/player/:id' => 'player#show', :as => 'show_player'

  #resource :player
  root :to => 'home#index'

end
