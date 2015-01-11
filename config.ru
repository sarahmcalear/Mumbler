require 'sinatra/base'
require 'redis'
require 'json'
require 'sinatra/reloader'

require_relative 'server'

run Mumbler::Server
