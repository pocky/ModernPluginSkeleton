.DEFAULT_GOAL := help

##
## Project setup
##---------------------------------------------------------------------------
.PHONY: install start stop

install: start ## Install requirements for tests
	sudo chmod -Rf 777 tests/Application/var
	sudo chmod -Rf 777 tests/Application/public/media
	docker compose exec php /usr/bin/composer install
	docker compose exec nodejs yarn --cwd tests/Application install
	docker compose exec php tests/Application/bin/console doctrine:database:create --if-not-exists -vvv
	docker compose exec php tests/Application/bin/console doctrine:schema:create -vvv
	docker compose exec php tests/Application/bin/console assets:install tests/Application/public -vvv
	docker compose exec nodejs yarn --cwd tests/Application build
	docker compose exec php tests/Application/bin/console cache:warmup -vvv
	docker compose exec php tests/Application/bin/console sylius:fixtures:load -n

start: ## Start the project
	docker compose up -d

stop: ## Stop and clean
	docker compose kill
	docker compose rm -v --force

clean: stop ## Clean plugin
	docker compose down -v
	sudo rm -Rf node_modules vendor .phpunit.result.cache composer.lock

##
## Assets
##---------------------------------------------------------------------------
.PHONY: assets assets-watch

assets: ## Build assets for dev environment
	docker compose exec nodejs yarn --cwd tests/Application build

assets-watch: ## Watch asset during development
	docker compose exec nodejs yarn --cwd tests/Application watch

##
## QA
##---------------------------------------------------------------------------
.PHONY: validate phpstan psalm phpspec phpunit behat

validate: ## Validate composer.json
	docker compose exec php composer validate --ansi --strict

phpstan: ## phpstan level max
	docker compose exec php vendor/bin/phpstan analyse -c phpstan.neon -l max src/

psalm: ## psalm
	docker compose exec php vendor/bin/psalm

phpspec: ## phpspec
	docker compose exec php vendor/bin/phpspec run --ansi -f progress --no-interaction

phpunit: ## phpunit
	docker compose exec php vendor/bin/phpunit --colors=always

behat: ## Run behat
	docker compose exec php vendor/bin/behat --profile docker --colors --strict -vvv --no-interaction

ci: validate phpstan psalm phpspec phpunit behat ## Execute github actions tasks

##
## Utilities
##---------------------------------------------------------------------------
.PHONY: help

help: ## Show all make tasks (default)
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

-include Makefile.local
