# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Ruby CLI gem called "worktreegroup" that executes `git worktree add` operations across multiple git repositories simultaneously. The tool is designed to be run from a directory containing multiple git repositories as subdirectories.

## Development Commands

### Testing and Quality
- `make test` - Run unit tests only (excludes e2e tests)
- `make test-unit` - Run unit tests only (same as `make test`)
- `make test-e2e` - Run end-to-end tests only
- `make test-all` - Run all tests (unit + e2e)
- `make lint` - Run Rubocop (has fallback for gem compatibility issues)
- `make format` - Auto-format code with Rubocop
- `make check` - Run unit tests and linting
- `make check-all` - Run all tests and linting
- `bundle exec rspec spec/path/to/specific_spec.rb` - Run single test file
- `bundle exec rspec spec/path/to/specific_spec.rb:42` - Run specific test by line number

### Development Setup
- `bundle install` - Install dependencies
- `bin/worktreegroup` - Run CLI directly from source

## Code Architecture

### High-Level Structure
The gem follows standard Ruby gem conventions with a simple, focused architecture:

```
lib/
├── worktreegroup.rb           # Main module, requires version and CLI
├── worktreegroup/
    ├── version.rb             # Version constant
    └── cli.rb                 # Thor-based CLI with all commands
```

### CLI Framework
- Uses **Thor** framework for command-line interface
- Entry point: `bin/worktreegroup` → `Worktreegroup::CLI.start(ARGV)`
- Default command is `hello`
- Main feature: `add` command that discovers git repos and executes worktree operations

### Core Functionality (CLI#add method)
1. **Repository Discovery**: Scans current directory for subdirectories containing `.git` folders
2. **Multi-Repository Execution**: Runs `git worktree add` with provided arguments across all found repositories
3. **Progress Tracking**: Reports success/failure for each repository with detailed output
4. **Error Handling**: Early returns for missing arguments or no repositories found

### Key Implementation Details
- Git repository detection via `Dir.glob("*/")` + `.git` folder check
- Uses `Dir.chdir` to execute commands in each repository context
- Silent command execution (`out: File::NULL, err: File::NULL`) with boolean return values
- Thor's `*ARGS` parameter captures all arguments for forwarding to git

## Testing Strategy

### Test Structure
- **Unit Tests** (`spec/worktreegroup/`): Fast isolated tests with mocked dependencies
- **E2E Tests** (`spec/e2e/`): Full integration tests with real git repositories and CLI execution
- Test files mirror `lib/` structure in `spec/`
- RSpec framework with comprehensive CLI testing

### Unit Test Patterns
- CLI instance testing with mocked dependencies (e.g., `allow(cli).to receive(:find_git_repositories)`)
- Output capture using `expect { }.to output().to_stdout`
- Error handling verification with exit code expectations

### E2E Test Framework
- Creates temporary git repositories using `Dir.mktmpdir`
- Executes actual CLI binary via `system()` calls
- Verifies real file system changes and git worktree operations
- Tests real multi-repository scenarios with proper cleanup
- Uses `around` blocks for proper test isolation

## Environment Notes
- Ruby >= 2.6.0 required
- CI runs on Ruby 3.4.4 (configured in mise.toml)
- Rubocop may have gem compatibility issues in some environments (handled gracefully in Makefile)
- GitHub Actions runs both test and lint targets