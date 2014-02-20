
all:

tags:
	etags `find $(PWD) -type f |grep -v \.git`

register:
	python setup.py sdist register

upload:
	python setup.py sdist upload

clean:
	rm -fr ve build dist *.egg-info *.pyc TAGS

ve:
	virtualenv --system-site-packages ve

install: ve
	ve/bin/python setup.py install

develop: ve
	ve/bin/python setup.py develop

t:
	python example/example.py riak_set_conflict_resolution_policy localhost yoyo --mode=data\
	| jq -M .
	@echo
	python example/example.py riak_set_conflict_resolution_policy localhost yoyo --mode=cmd
	@echo
	python example/example.py riak_set_conflict_resolution_policy localhost yoyo --mode=data,cmd

