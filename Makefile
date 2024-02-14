MAIN_FILE ?= ./cmd/keyfob/main.go
OUT_BIN ?= keyfob
OUT_FILE ?= build/${OUT_BIN}

GOVERSION = "$(cat go.mod | grep -e '^go' | awk '{print $2}')"

${OUT_FILE}: clean ## build the application
	go build -o ${OUT_FILE} ${MAIN_FILE}

.PHONY: run
run: build ## executes "go run" on the main file
	go run -race ${MAIN_FILE}

.PHONY: clean
clean: ## cleans the build output
	go clean -x

.PHONY: mod
mod: ## setup go modules
	@go mod tidy \
		&& go mod vendor

help: ## prints this message
	@printf "${OUT_BIN} usage: \n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}'
