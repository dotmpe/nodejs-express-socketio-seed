TRGTS := build-clients build
default:
	echo 'use npm [start|run build]'
	echo 'Make targets: $(TRGTS)'

build:
	npm run build

.PHONY: $(TRGTS)

COFFEE2JS := \
	src/dotmpe/project/client/document.coffee \
	src/dotmpe/browser/client/main.coffee
CLN_JS := $(COFFEE2JS:%.coffee=%.js)

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
	@echo "Cleaning..";rm -v $(CLN_JS)

