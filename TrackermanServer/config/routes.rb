# == Route Map
#
#                      Prefix Verb   URI Pattern                            Controller#Action
#            new_user_session GET    /users/sign_in(.:format)               devise/sessions#new
#                user_session POST   /users/sign_in(.:format)               devise/sessions#create
#        destroy_user_session DELETE /users/sign_out(.:format)              devise/sessions#destroy
#               user_password POST   /users/password(.:format)              devise/passwords#create
#           new_user_password GET    /users/password/new(.:format)          devise/passwords#new
#          edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
#                             PATCH  /users/password(.:format)              devise/passwords#update
#                             PUT    /users/password(.:format)              devise/passwords#update
#    cancel_user_registration GET    /users/cancel(.:format)                devise/registrations#cancel
#           user_registration POST   /users(.:format)                       devise/registrations#create
#       new_user_registration GET    /users/sign_up(.:format)               devise/registrations#new
#      edit_user_registration GET    /users/edit(.:format)                  devise/registrations#edit
#                             PATCH  /users(.:format)                       devise/registrations#update
#                             PUT    /users(.:format)                       devise/registrations#update
#                             DELETE /users(.:format)                       devise/registrations#destroy
#                      places GET    /places(.:format)                      places#index
#                             POST   /places(.:format)                      places#create
#                   new_place GET    /places/new(.:format)                  places#new
#                  edit_place GET    /places/:id/edit(.:format)             places#edit
#                       place GET    /places/:id(.:format)                  places#show
#                             PATCH  /places/:id(.:format)                  places#update
#                             PUT    /places/:id(.:format)                  places#update
#                             DELETE /places/:id(.:format)                  places#destroy
#                       areas GET    /areas(.:format)                       areas#index
#                             POST   /areas(.:format)                       areas#create
#                    new_area GET    /areas/new(.:format)                   areas#new
#                   edit_area GET    /areas/:id/edit(.:format)              areas#edit
#                        area GET    /areas/:id(.:format)                   areas#show
#                             PATCH  /areas/:id(.:format)                   areas#update
#                             PUT    /areas/:id(.:format)                   areas#update
#                             DELETE /areas/:id(.:format)                   areas#destroy
#                       zones GET    /zones(.:format)                       zones#index
#                             POST   /zones(.:format)                       zones#create
#                    new_zone GET    /zones/new(.:format)                   zones#new
#                   edit_zone GET    /zones/:id/edit(.:format)              zones#edit
#                        zone GET    /zones/:id(.:format)                   zones#show
#                             PATCH  /zones/:id(.:format)                   zones#update
#                             PUT    /zones/:id(.:format)                   zones#update
#                             DELETE /zones/:id(.:format)                   zones#destroy
#                             GET    /places(.:format)                      places#index
#                             POST   /places(.:format)                      places#create
#                             GET    /places/new(.:format)                  places#new
#                             GET    /places/:id/edit(.:format)             places#edit
#                             GET    /places/:id(.:format)                  places#show
#                             PATCH  /places/:id(.:format)                  places#update
#                             PUT    /places/:id(.:format)                  places#update
#                             DELETE /places/:id(.:format)                  places#destroy
#                   treasures GET    /treasures(.:format)                   treasures#index
#                             POST   /treasures(.:format)                   treasures#create
#                new_treasure GET    /treasures/new(.:format)               treasures#new
#               edit_treasure GET    /treasures/:id/edit(.:format)          treasures#edit
#                    treasure GET    /treasures/:id(.:format)               treasures#show
#                             PATCH  /treasures/:id(.:format)               treasures#update
#                             PUT    /treasures/:id(.:format)               treasures#update
#                             DELETE /treasures/:id(.:format)               treasures#destroy
#          api_v1_get_players GET    /api/v1/get_players(.:format)          api/v1/service#get_players
#            api_v1_get_zones GET    /api/v1/get_zones(.:format)            api/v1/service#get_zones
#        api_v1_create_player POST   /api/v1/create_player(.:format)        api/v1/service#create_player
#              api_v1_add_pos POST   /api/v1/add_pos(.:format)              api/v1/service#add_pos
#             api_v1_ping_ios POST   /api/v1/ping_ios(.:format)             api/v1/service#ping_ios
#         api_v1_ping_android GET    /api/v1/ping_android(.:format)         api/v1/service#ping_android
# api_v1_get_treasures_within GET    /api/v1/get_treasures_within(.:format) api/v1/service#get_treasures_within
#             api_v1_sessions POST   /api/v1/sessions(.:format)             api/v1/sessions#create
#                     players GET    /players(.:format)                     players#index
#                 show_player GET    /player/:id(.:format)                  players#show
#                        root GET    /                                      home#index
#

Rails.application.routes.draw do

  devise_for :users

  resources :places
  resources :areas

  resources :zones
  resources :places
  resources :treasures

  # we use Devise...
  #get    'signup'  => 'users#new'
  #get    'login'   => 'sessions#new'
  #post   'login'   => 'sessions#create'
  #delete 'logout'  => 'sessions#destroy'

  namespace :api do
    namespace :v1 do
      get  'get_players'            => 'service#get_players'
      get  'get_zones'              => 'service#get_zones'
      post 'create_player'          => 'service#create_player'
      post 'add_pos'                => 'service#add_pos'

      post 'ping_ios'               => 'service#ping_ios'
      get  'ping_android'           => 'service#ping_android'
      get  'get_treasures_within'   => 'service#get_treasures_within'

      resources :sessions, only: [:create]
    end

  end


  get  '/players'               => 'players#index'
  get  '/player/:id'            => 'players#show', :as => 'show_player'

  root :to => 'home#index'


  # Catch invalid routes!
  #match ':not_found' => 'my_controller#index',
   #     :constraints => { :not_found => /.*/ }

  #If you only want to redirect, nothing more, you could do this instead (again, at the bottom):
  #match ':not_found' => redirect('/'), :constraints => { :not_found => /.*/ }

end
