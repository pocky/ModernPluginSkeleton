<p align="center">
    <a href="https://sylius.com" target="_blank">
        <img src="https://demo.sylius.com/assets/shop/img/logo.png" />
    </a>
</p>

<h1 align="center">Modern Plugin Skeleton</h1>

<p align="center">Modern Skeleton for starting Sylius plugins.</p>

## Warning

This plugin DOES NOT follow standard Sylius directory structure for plugins but a new "Symfony standard skeleton" one
and services declaration in PHP (Symfony is actually leaving xml for PHP).

New directory structure:

```
├── assets
├── bin
├── config
├── docs
├── etc
├── features
├── public
├── src
├── templates
├── tests
└── translations
```

Informations:
- Related pull request on github (Symfony): https://github.com/symfony/symfony/pull/32845
- Document for Symfony Bundle: https://github.com/yceruto/acme-bundle

## Quickstart Installation (docker)

1. Run `composer create-project pocky/modern-plugin-skeleton ProjectName` or clone this project

2. From the plugin skeleton root directory, run the following commands:

```bash
$ sudo chmod -Rf 777 tests/Application/var
$	docker-compose exec php php -d memory_limit=-1 /usr/bin/composer install
$	docker-compose exec nodejs yarn --cwd tests/Application install
$	docker-compose exec php tests/Application/bin/console doctrine:database:create --if-not-exists -vvv
$	docker-compose exec php tests/Application/bin/console doctrine:schema:create -vvv
$	docker-compose exec php tests/Application/bin/console assets:install tests/Application/public -vvv
$	docker-compose exec nodejs yarn --cwd tests/Application build
$	docker-compose exec php tests/Application/bin/console cache:warmup -vvv
$	docker-compose exec php tests/Application/bin/console sylius:fixtures:load -n
```
 
### Quality tools

```bash
$ docker-compose exec php composer validate --ansi --strict
$ docker-compose exec php vendor/bin/phpstan analyse -c phpstan.neon -l max src/
$ docker-compose exec php vendor/bin/psalm
$ docker-compose exec php vendor/bin/phpspec run --ansi -f progress --no-interaction
$ docker-compose exec php vendor/bin/phpunit --colors=always
$ docker-compose exec php vendor/bin/behat --profile docker --colors --strict -vvv --no-interaction
``` 
 __ProTip__ use `Makefile` ;)
    
## Official Documentation

For a comprehensive guide on Sylius Plugins development please go to Sylius documentation,
there you will find the <a href="https://docs.sylius.com/en/latest/plugin-development-guide/index.html">Plugin Development Guide</a>, that is full of examples.

## Quickstart Installation (legacy)

1. Run `composer create-project pocky/modern-plugin-skeleton ProjectName`.

2. From the plugin skeleton root directory, run the following commands:

    ```bash
    $ (cd tests/Application && yarn install)
    $ (cd tests/Application && yarn build)
    $ (cd tests/Application && APP_ENV=test bin/console assets:install public)
    
    $ (cd tests/Application && APP_ENV=test bin/console doctrine:database:create)
    $ (cd tests/Application && APP_ENV=test bin/console doctrine:schema:create)
    ```

To be able to setup a plugin's database, remember to configure you database credentials in `tests/Application/.env` and `tests/Application/.env.test`.

## Usage

### Running plugin tests

  - PHPUnit

    ```bash
    vendor/bin/phpunit
    ```

  - PHPSpec

    ```bash
    vendor/bin/phpspec run
    ```

  - Behat (non-JS scenarios)

    ```bash
    vendor/bin/behat --strict --tags="~@javascript"
    ```

  - Behat (JS scenarios)
 
    1. [Install Symfony CLI command](https://symfony.com/download).
 
    2. Start Headless Chrome:
    
      ```bash
      google-chrome-stable --enable-automation --disable-background-networking --no-default-browser-check --no-first-run --disable-popup-blocking --disable-default-apps --allow-insecure-localhost --disable-translate --disable-extensions --no-sandbox --enable-features=Metal --headless --remote-debugging-port=9222 --window-size=2880,1800 --proxy-server='direct://' --proxy-bypass-list='*' http://127.0.0.1
      ```
    
    3. Install SSL certificates (only once needed) and run test application's webserver on `127.0.0.1:8080`:
    
      ```bash
      symfony server:ca:install
      APP_ENV=test symfony server:start --port=8080 --dir=tests/Application/public --daemon
      ```
    
    4. Run Behat:
    
      ```bash
      vendor/bin/behat --strict --tags="@javascript"
      ```
    
  - Static Analysis
  
    - Psalm
    
      ```bash
      vendor/bin/psalm
      ```
      
    - PHPStan
    
      ```bash
      vendor/bin/phpstan analyse -c phpstan.neon -l max src/  
      ```

  - Coding Standard
  
    ```bash
    vendor/bin/ecs check src
    ```

### Opening Sylius with your plugin

- Using `test` environment:

    ```bash
    (cd tests/Application && APP_ENV=test bin/console sylius:fixtures:load)
    (cd tests/Application && APP_ENV=test bin/console server:run -d public)
    ```
    
- Using `dev` environment:

    ```bash
    (cd tests/Application && APP_ENV=dev bin/console sylius:fixtures:load)
    (cd tests/Application && APP_ENV=dev bin/console server:run -d public)
    ```
