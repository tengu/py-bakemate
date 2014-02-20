#!/usr/bin/env python
import sys,os
import json
import baker
sys.path.append(os.path.abspath('.'))
import bakemate

@bakemate.http_request
def riak_set_conflict_resolution_policy(server, bucket):
    """set the coflict resolution policy to 'last write wins'"""
    return dict(url="http://{server}:8098/buckets/{bucket}/props".format(**locals()),
                method="PUT",
                headers={"Content-Type": "application/json"},
                data={"props": { "last_write_wins": False, "allow_mult": False }})

baker.command(riak_set_conflict_resolution_policy)

baker.run()
