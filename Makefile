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

start: # Start all services or by a profile: make start profile=media
	@if [ ! -f .env ]; then \
		echo "ERROR: .env file not found. Check .env.example"; \
		exit 1; \
	fi

	mkdir -p ~/media/pending ~/media/finished/movies ~/media/finished/shows ~/archive

	@if [ -z "$(profile)" ]; then \
		$(DOCKER_COMPOSE) --profile "*" up -d --remove-orphans; \
	else \
		$(DOCKER_COMPOSE) --profile "$(profile)" up -d --remove-orphans; \
	fi

stop: # Stop all services
	$(DOCKER_COMPOSE) --profile "*" down;

log: # Tail all logs
	$(DOCKER_COMPOSE) --profile "*" logs -f --tail=500

ps: # Check all running services
	$(DOCKER_COMPOSE) --profile "*" ps
