require 'redis'
redis = Redis.new

redis.flushdb

redis.set("mumble_id", 0)

id = redis.incr("mumble_id")
redis.hmset(
  "mumble:#{id}",
  "text", "hello from the first mumble",
  "image", "http://upload.wikimedia.org/wikipedia/commons/0/06/Kitten_in_Rizal_Park,_Manila.jpg",
  "date", "2004-12-09",
  "tags", "kittens",
  "author_email", "someone@aol.com",
  "author_handle", "someone",
  "author_thumbnail", "http://onebigphoto.com/cute-mini-lion-kitten/",
  "likes", "0",
  )
redis.lpush("mumble_ids", id)

id = redis.incr("mumble_id")
redis.hmset(
  "mumble:#{id}",
  "text", "hello from the second mumble",
  "image", "http://a.dilcdn.com/bl/wp-content/uploads/sites/8/2012/05/beagle-puppy.jpg",
  "date", "2006-02-19",
  "tags", "puppies",
  "author_email", "anyone@aol.com",
  "author_handle", "anyone",
  "author_thumbnail", "http://sunnylol.com/images/2012/August/15/502ba65e50429.jpg",
  "likes", "0",
  )
redis.lpush("mumble_ids", id)
