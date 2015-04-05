TRGTS := install update build build-client info version latest test lint start

empty := 
space := $(empty) $(empty)
default:
	@echo 'usage:'
	@echo '# npm [start|test|run build]'
	@echo '# make [$(subst $(space),|,$(TRGTS))]'

install:
	npm install
	bower install
	make test

lint:
	grunt lint

test: lint
	npm test
	grunt test

update:
	npm update
	bower update

build: TODO.list latest build-client

build-client:
	grunt client
	grunt client-index

info:
	npm run srctree
	npm run srcloc

start:
	npm run start

.PHONY: $(TRGTS)


version: D := demo
version:
	DBNAME=$(D) ./node_modules/.bin/knex migrate:currentVersion

latest: D := demo
latest:
	DBNAME=$(D) ./node_modules/.bin/knex migrate:latest

COFFEE2JS := \
	src/dotmpe/browser/client/main.coffee
#	src/dotmpe/project/client/document.coffee \
#	src/dotmpe/project/client/ng.coffee 
_CLN := \
	$(COFFEE2JS:%.coffee=%.js)
#	public/script/project/document.coffee \
#	public/script/project/ng.coffee \
#	public/script/browser/main.coffee

build-clients:
	@for x in $(COFFEE2JS); \
	do \
		coffee --compile $$x; \
	done
	@for x in ./*.build.js; \
	do \
		echo "Found $$x, optimizing..."; \
		r.js -o $$x; \
		echo "$$x done"; \
	done
	@echo "Cleaning..";rm -v $(_CLN)

TODO.list: Makefile src lib config ReadMe.rst Gruntfile.js server.coffee
	grep -srI 'TODO\|FIXME\|XXX' $^ | grep -v 'grep..srI..TODO' | grep -v 'TODO.list' > $@

