FORMATTING_BEGIN_YELLOW = \033[0;33m
FORMATTING_BEGIN_BLUE = \033[36m
FORMATTING_END = \033[0m
UNITTEST_VERSION = 0.3.0

help:
	@printf -- "${FORMATTING_BEGIN_BLUE}%s${FORMATTING_END}\n" \
	"Deckhouse lib-helm" \
	"-----------------------------------------------------------------------------------" \
	""
	@awk 'BEGIN {\
	    FS = ":.*##"; \
	    printf                "Usage: ${FORMATTING_BEGIN_BLUE}OPTION${FORMATTING_END}=<value> make ${FORMATTING_BEGIN_YELLOW}<target>${FORMATTING_END}\n"\
	  } \
	  /^[a-zA-Z0-9_/-]+:.*?##/ { printf "  ${FORMATTING_BEGIN_BLUE}%-46s${FORMATTING_END} %s\n", $$1, $$2 } \
	  /^.?.?##~/              { printf "   %-46s${FORMATTING_BEGIN_YELLOW}%-46s${FORMATTING_END}\n", "", substr($$1, 6) } \
	  /^##@/                  { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)



##@ Documentation
.PHONY: doc/build
doc/build: ## Rebuild documentation 'charts/helm_lib/README.md' file
	go run tools/build-doc.go

.PHONY: doc/diff
doc/diff: ## Check documentation 'charts/helm_lib/README.md' was rebuilt only
	go run tools/build-doc.go --diff

##@ Testing

.PHONY: ci/tests/install-plugin
ci/tests/unit/install-plugin: ## Install unittest plugin locally
	helm plugin list | grep -q unittest || helm plugin install --version $(UNITTEST_VERSION) https://github.com/helm-unittest/helm-unittest

.PHONY: ci/tests/unit
ci/tests/unit: ## Run unittest locally
	helm unittest $(CURDIR)/tests/

.PHONY: ci/tests/unit/update-snapshot
ci/tests/unit/update-snapshot: ## Run unittest locally
	helm unittest $(CURDIR)/tests/ -u

.PHONY: ci/tests/unit/run
ci/tests/unit/run: ci/tests/unit/install-plugin ci/tests/unit ## Install plugin and run unittests

.PHONY: ci/tests/unit/update-snapshot/run
ci/tests/unit/update-snapshot/run: ci/tests/unit/install-plugin ci/tests/unit/update-snapshot ## Install plugin and run unittests with snapshot updating

.PHONY: tests/unit
tests/unit: ## Run unit tests for lib-helm
	docker run -ti --rm -v $(CURDIR):/apps helmunittest/helm-unittest:3.11.1-$(UNITTEST_VERSION) ./tests

.PHONY: tests/unit/update-snapshot
tests/unit/update-snapshot: ## Update tests snapshot https://github.com/helm-unittest/helm-unittest/blob/main/README.md#snapshot-testing
	docker run -ti --rm -v $(CURDIR):/apps helmunittest/helm-unittest:3.11.1-$(UNITTEST_VERSION)
