# special rule targets
STRGTS := \
   default \
   info \
   version latest \
   lint \
   test \
   build build-client \
   install \
   update \
   publish \
   start

.PHONY: $(STRGTS)

empty :=
space := $(empty) $(empty)
default:
	@echo 'usage:'
	@echo '# npm [start|test|run build]'
	@echo '# grunt [lint|..]'
	@echo '# make [$(subst $(space),|,$(STRGTS))]'

install:
	npm install
	bower install
	make test

update:
	npm update
	bower update

lint:
	grunt lint

test:
	#NODE_ENV=development coffee test/runner.coffee

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


VERSION :=

publish: DRY := yes
publish:
	@[ -z "$(VERSION)" ] && exit 1 || echo Publishing $(VERSION)
	grep version..$(VERSION) ReadMe.rst
	@./check.coffee $(VERSION)
	git push

TODO.list: Makefile src lib config ReadMe.rst Gruntfile.js server.coffee
	grep -srI 'TODO\|FIXME\|XXX' $^ | grep -v 'grep..srI..TODO' | grep -v 'TODO.list' > $@

