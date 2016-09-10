Rails.application.routes.draw do

  resources :places
  resources :areas
  devise_for :users

  resources :zones
  resources :places
  resources :treasures

  namespace :api do
    namespace :v1 do
      get  'get_players'            => 'service#get_players'
      get  'get_zones'              => 'service#get_zones'
      post 'create_player'          => 'service#create_player'
      post 'add_pos'                => 'service#add_pos'

      post 'ping_ios'               => 'service#ping_ios'
      get  'ping_android'           => 'service#ping_android'
      get  'get_treasures_within'   => 'service#get_treasures_within'

      get  '/players'               => 'player#index'
      get  '/player/:id'            => 'player#show', :as => 'show_player'
    end
  end


  #resource :player
  root :to => 'home#index'


  # Catch invalid routes!
  #match ':not_found' => 'my_controller#index',
   #     :constraints => { :not_found => /.*/ }

  #If you only want to redirect, nothing more, you could do this instead (again, at the bottom):
  #match ':not_found' => redirect('/'), :constraints => { :not_found => /.*/ }

end
