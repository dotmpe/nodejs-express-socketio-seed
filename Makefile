TRGTS := install update build build-clients info test lint

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

migrate:
	knex migrate:latest

build: migrate build-clients

info:
	npm run srctree
	npm run srcloc

.PHONY: $(TRGTS)

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

