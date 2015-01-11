require 'sinatra/base'
require 'httparty'
require 'date'
require 'redis'
require 'json'
require 'digest/md5'
require 'sinatra/reloader'

require_relative 'database_helper'
require_relative 'server'

run Mumbler::Server
