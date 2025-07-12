# Worktreegroup

[![Test](https://github.com/nasustim/worktreegroup-rb/actions/workflows/test.yml/badge.svg)](https://github.com/nasustim/worktreegroup-rb/actions/workflows/test.yml)
[![Build](https://github.com/nasustim/worktreegroup-rb/actions/workflows/build.yml/badge.svg)](https://github.com/nasustim/worktreegroup-rb/actions/workflows/build.yml)
[![Release](https://github.com/nasustim/worktreegroup-rb/actions/workflows/release.yml/badge.svg)](https://github.com/nasustim/worktreegroup-rb/actions/workflows/release.yml)
[![Gem Version](https://badge.fury.io/rb/worktreegroup.svg)](https://badge.fury.io/rb/worktreegroup)

A powerful CLI tool for managing Git worktrees across multiple repositories simultaneously. Execute `git worktree` operations on all Git repositories in your current directory with a single command.

## Installation

### From RubyGems

Install the gem directly:

```bash
gem install worktreegroup
```

Or add to your Gemfile:

```ruby
gem 'worktreegroup'
```

Then execute:

```bash
bundle install
```

### From GitHub Releases

Download the latest `.gem` file from [GitHub Releases](https://github.com/nasustim/worktreegroup-rb/releases) and install:

```bash
gem install worktreegroup-x.x.x.gem
```

### From GitHub Packages

Configure GitHub Packages as a gem source:

```bash
# Configure GitHub Packages (one-time setup)
echo ":github: Bearer YOUR_GITHUB_TOKEN" >> ~/.gem/credentials
chmod 0600 ~/.gem/credentials

# Add GitHub Packages as gem source
gem sources --add https://rubygems.pkg.github.com/nasustim

# Install the gem
gem install worktreegroup --source https://rubygems.pkg.github.com/nasustim
```

### Verify Installation

After installation, verify that worktreegroup is working:

```bash
worktreegroup version
worktreegroup --help
```

## Usage

### Prerequisites

This tool is designed to be run from a directory that contains multiple Git repositories as subdirectories. For example:

```
current-directory/
├── repo1/
│   └── .git/
├── repo2/  
│   └── .git/
└── repo3/
    └── .git/
```

### Basic Commands

Show greeting message (default command):
```bash
worktreegroup
# or explicitly
worktreegroup hello
```

Show version:
```bash
worktreegroup version
```

### Worktree Management

Add worktrees to all Git repositories in the current directory:
```bash
worktreegroup add <path> [<commit-ish>]
```

This command accepts the same arguments as `git worktree add` and executes the operation across all Git repositories found in the current directory.

#### Examples

Create a new worktree for feature branch in all repositories:
```bash
worktreegroup add -b feature/new-feature ../feature-branch
```

Add worktree from existing branch:
```bash
worktreegroup add ../hotfix develop
```

Add worktree with detached HEAD:
```bash
worktreegroup add --detach ../temp-work v1.0.0
```

## Development

After checking out the repo, run `bundle install` to install dependencies.

### Available Commands

- `make test` - Run unit tests only
- `make test-e2e` - Run end-to-end tests only  
- `make test-all` - Run all tests
- `make lint` - Run code linting
- `make format` - Auto-format code
- `make check-all` - Run tests and linting

### Testing Locally

```bash
# Install dependencies
bundle install

# Run all tests
make test-all

# Build and install gem locally
gem build worktreegroup.gemspec
gem install *.gem

# Test the CLI
worktreegroup --help
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nasustim/worktreegroup-rb.

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines and setup instructions.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).