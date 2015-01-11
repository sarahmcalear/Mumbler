module Mumbler
  module DatabaseHelper

    $redis = Redis.new

    def likes_for(id)
      $redis.hget("mumble:#{id}", "likes")
    end

    def like!(id)
      $redis.hincrby("mumble:#{id}", "likes", 1)
    end

  end
end
