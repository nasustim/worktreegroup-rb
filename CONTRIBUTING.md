# Contributing to Worktreegroup

Thank you for your interest in contributing to Worktreegroup! This document provides guidelines for contributing to the project.

## Development Setup

1. Fork and clone the repository:
   ```bash
   git clone https://github.com/your-username/worktreegroup-rb.git
   cd worktreegroup-rb
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Run tests to ensure everything works:
   ```bash
   make test-all
   ```

## Development Commands

- `make test` - Run unit tests only
- `make test-e2e` - Run end-to-end tests only
- `make test-all` - Run all tests
- `make lint` - Run code linting
- `make format` - Auto-format code
- `make check-all` - Run tests and linting

## Testing

We use RSpec for testing with two types of tests:

- **Unit Tests** (`spec/worktreegroup/`): Fast isolated tests with mocked dependencies
- **E2E Tests** (`spec/e2e/`): Integration tests with real git repositories

Please ensure:
- All new features have comprehensive tests
- Both unit and e2e tests pass
- Code follows the existing style

## Submitting Changes

1. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and add tests

3. Ensure all tests pass:
   ```bash
   make test-all
   make lint
   ```

4. Commit your changes with descriptive messages

5. Push and create a pull request

## Code Style

- Follow Ruby community conventions
- Use descriptive variable and method names
- Add comments for complex logic
- Ensure consistent error handling patterns

## Reporting Issues

When reporting issues, please include:
- Ruby version
- Gem version
- Operating system
- Steps to reproduce
- Expected vs actual behavior

## Release Process

Releases are handled by maintainers using the `bin/release` script, which:
- Updates the version number
- Runs tests
- Creates git tags
- Triggers automated publishing via GitHub Actions

Thank you for contributing!