#
# Authors:
#  - Abhimanyu Saharan <asaharan@onemindservices.com>
#

SHELL=/bin/bash

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Builds the schema
	./build.sh

tests: ## Runs tests
	@tox