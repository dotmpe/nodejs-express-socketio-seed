TRGTS := install update build build-client info version latest test lint start

.PHONY: $(TRGTS)


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

# TODO: find module.meta files instead of hardcoding module paths
build-client:
	-rm -rf public/script/dotmpe
	mkdir -p public/script/dotmpe
	find src -iname module.meta | while read mod; \
	do echo $$mod; ./build.coffee $$mod; done
	@echo Done
	@tree public/script

info:
	npm run srctree
	npm run srcloc

start:
	npm run start



version: D := demo
version:
	DBNAME=$(D) ./node_modules/.bin/knex migrate:currentVersion

latest: D := demo
latest:
	DBNAME=$(D) ./node_modules/.bin/knex migrate:latest


TODO.list: Makefile src lib config ReadMe.rst Gruntfile.js server.coffee
	grep -srI 'TODO\|FIXME\|XXX' $^ | grep -v 'grep..srI..TODO' | grep -v 'TODO.list' > $@

