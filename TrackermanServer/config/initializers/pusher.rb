# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = '239066'
Pusher.key = '2294c2161e73ddea29a1'
Pusher.secret = '9692a2665cf6c72343a6'
Pusher.logger = Rails.logger
Pusher.encrypted = true
