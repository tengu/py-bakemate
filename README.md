bakemate
========

A baker adoptor. It's hard to explain. Please see example below.

### example: http request 

* command/function that results in a http request

Just write a function that returns a dict representing the http request.
@bakemate.http_requst-decorated command can yield json data, 
Curl command invocation, actually make the request or any combintion.

           import baker
           import bakemate
           
           @bakemate.http_requst
           def riak_set_conflict_resolution_policy(server, bucket):

	       # just return a dict defining the http requst
               return dict(url="http://{server}:8098/buckets/{bucket}/props".format(**locals()),
                           method="PUT",
                           headers={"Content-Type": "application/json"},
                           data={"props": { "last_write_wins": False, "allow_mult": False }})
           
           baker.command(riak_set_conflict_resolution_policy)

* just dump the json representation of the request

           example.py riak_set_conflict_resolution_policy localhost yoyo --mode=data | jq -M .
           {
             "method": "PUT",
             "data": {
               "props": {
                 "allow_mult": false,
                 "last_write_wins": false
               }
             },
             "headers": {
               "Content-Type": "application/json"
             },
             "url": "http://localhost:8098/buckets/yoyo/props"
           }

* suggest a curl invocation that would do the job

           example.py riak_set_conflict_resolution_policy localhost yoyo --mode=cmd

           curl -XPUT --data{"props": {"last_write_wins": false, "allow_mult": false}} -H"Content-Type: application/json" http://localhost:8098/buckets/yoyo/props

* both
           example.py riak_set_conflict_resolution_policy localhost yoyo --mode=data,cmd

           {"url": "http://localhost:8098/buckets/yoyo/props", "headers": {"Content-Type": "application/json"}, "data": {"props": {"last_write_wins": false, "allow_mult": false}}, "method": "PUT"}

           curl -XPUT --data{"props": {"last_write_wins": false, "allow_mult": false}} -H"Content-Type: application/json" http://localhost:8098/buckets/yoyo/props

* actually make the request

           example.py riak_set_conflict_resolution_policy localhost yoyo --mode=run

* print command and make the request

           example.py riak_set_conflict_resolution_policy localhost yoyo --mode=cmd,run


### adoptors

Similar adopters can be defined to drive any complex software interface.

