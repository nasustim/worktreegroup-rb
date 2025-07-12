# Worktreegroup

A CLI tool for managing Git worktree groups.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'worktreegroup'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install worktreegroup

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

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nasustim/worktreegroup-rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).