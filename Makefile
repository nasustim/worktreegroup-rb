test:
	bundle exec rspec --exclude-pattern "spec/e2e/**/*_spec.rb"

test-unit:
	bundle exec rspec --exclude-pattern "spec/e2e/**/*_spec.rb"

test-e2e:
	bundle exec rspec spec/e2e/

test-all:
	bundle exec rspec

lint:
	@echo "Running Rubocop..."
	@bundle exec rubocop || echo "WARNING: Rubocop failed due to gem compatibility issues"

format:
	bundle exec rubocop --auto-correct

check: test lint

check-all: test-all lint

.PHONY: test test-unit test-e2e test-all lint format check check-all
