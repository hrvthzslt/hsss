.PHONY: help
.DEFAULT_GOAL := help

DC_EXITS := $(shell docker compose > /dev/null 2>&1 ; echo $$?)

ifeq ($(DC_EXITS),0)
	DOCKER_COMPOSE = docker compose
else
	DOCKER_COMPOSE = docker-compose
endif

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: # Start the stack
	mkdir -p ~/media/pending ~/media/finished/movies ~/media/finished/shows ~/archive
	@read -p "Enter user: " user; \
	read -p "Enter pass: " pass; \
	U=$$user P=$$pass $(DOCKER_COMPOSE) up -d --remove-orphans;

.PHONY: stop
stop: # Stop the stack
	@U="" P="" $(DOCKER_COMPOSE) down;

.PHONY: log
log: # Tail the logs
	@U="" P="" $(DOCKER_COMPOSE) logs -f --tail=500

.PHONY: ps
ps: # List running services
	@U="" P="" $(DOCKER_COMPOSE) ps
