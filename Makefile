#
# Authors:
#  - Abhimanyu Saharan <asaharan@onemindservices.com>
#
SHELL=/bin/bash

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

check:
	@if [ -z $(VERSION) ]; then \
		echo "VERSION was not set"; \
		echo "Usage:"; \
		echo "VERSION=v1.20.0 make build"
		exit 1; \
	fi


build: check ## Builds the schema
	./build.sh $(VERSION)
	./buid.sh master

tests: ## Runs tests
	@tox