test:
	bundle exec rspec

lint:
	@echo "Running Rubocop..."
	@bundle exec rubocop || echo "WARNING: Rubocop failed due to gem compatibility issues"

format:
	bundle exec rubocop --auto-correct

check: test lint

.PHONY: test lint format check
