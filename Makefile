compose = docker compose
inferno = run inferno

.PHONY: pull build up stop down migrate setup run tests rubocop run_cli

pull:
	$(compose) pull

build:
	$(compose) build

up:
	$(compose) up

stop:
	$(compose) stop

down:
	$(compose) down

migrate:
	$(compose) $(inferno) bundle exec inferno migrate

setup: pull build migrate

run: build up

restart: stop down pull build migrate up

run_cli:
	$(compose) $(inferno) bundle exec inferno execute --suite ips_suite --inputs "url:$(CLI_URL)" patient_id:$(CLI_PATIENT_ID) --outputter json

CLI_URL ?= "https://hl7-ips-server.hl7.org/fhir"
CLI_PATIENT_ID ?= "example-r4"

tests:
	$(compose) $(inferno) bundle exec rspec

rubocop:
	$(compose) $(inferno) rubocop

generate:
	sudo rm -rf lib/inferno_ips/generated/
	$(compose) $(inferno) bundle exec rake ips:generate
	$(compose) $(inferno) rubocop -A

generate_local:
	sudo rm -rf lib/inferno_ips/generated/
	bundle exec rake ips:generate
	rubocop -A .
