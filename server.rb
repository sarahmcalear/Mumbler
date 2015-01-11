require_relative 'database_helper'

module Mumbler
  class Server < Sinatra::Base
    helpers Mumbler::DatabaseHelper

    configure :development do
      register Sinatra::Reloader
      require 'pry'
      $redis = Redis.new
    end

    configure :production do
      $redis = Redis.new({url: ENV['REDISTOGO_URL']})
    end


    get('/') do
      redirect('/mumbles')
    end

    get('/mumbles') do
      ids = $redis.lrange("mumble_ids", 0, -1)
      @mumbles = ids.map do |id|
        $redis.hgetall("mumble:#{id}")
      end
      render(:erb, :index, {:layout => :default})
    end

    get('/mumble/new') do
      render(:erb, :new, {:layout => :default})
    end

    get('/mumble/:id') do
      @id = params[:id].to_i
      @mumble = $redis.hgetall("mumble:#{@id}")
      if params[:like] == 'true'
        like!(@id)
        redirect("/mumble/#{@id}")
      else
       render(:erb, :show, {:layout => :default})
     end
    end

    post('/mumbles') do
      id = $redis.incr("mumble_id")
      $redis.hmset(
        "mumble:#{id}",
        "text", params["text"],
        "image", params["image"],
        "date", Date.parse(params["date"]).strftime("%b %d, %Y"),
        "tags", params["tags"],
        "author_email", params["author_email"],
        "author_handle", params["author_handle"],
        "author_thumbnail", params["author_thumbnail"],
        "likes", "0"
        )
      $redis.lpush("mumble_ids", id)
      redirect('/mumbles')
    end

  end
end
