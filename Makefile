.PHONY: help
.DEFAULT_GOAL := help

DC_EXISTS := $(shell docker compose > /dev/null 2>&1 ; echo $$?)

ifeq ($(DC_EXISTS),0)
	DOCKER_COMPOSE = docker compose
else
	DOCKER_COMPOSE = docker-compose
endif

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

prepare-volumes:
	@mkdir -p /docker/volumes/jellyfin/config \
		/docker/volumes/transmission/config \
		/docker/volumes/media/finished/shows \
		/docker/volumes/media/finished/movies \
		/docker/volumes/media/pending \
		/docker/volumes/archive

start: prepare-volumes # Start all services or by a profile: make start profile=media
	@if [ ! -f .env ]; then \
		echo "ERROR: .env file not found. Check .env.example"; \
		exit 1; \
	fi

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
