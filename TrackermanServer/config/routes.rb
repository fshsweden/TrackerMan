Rails.application.routes.draw do

  resources :treasures
  get 'api/get_users'       => 'service#get_users'
  post 'api/create_player'  => 'service#create_player'
  post 'api/add_pos'        => 'service#add_pos'

  get '/players'    => 'player#index'
  get '/player/:id' => 'player#show', :as => 'show_player'

  #resource :player

end
