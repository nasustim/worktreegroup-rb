# frozen_string_literal: true

require_relative "lib/worktreegroup/version"

Gem::Specification.new do |spec|
  spec.name = "worktreegroup"
  spec.version = Worktreegroup::VERSION
  spec.authors = ["nasustim"]
  spec.email = ["nasustim@users.noreply.github.com"]

  spec.summary = "Multi-repository Git worktree management CLI tool"
  spec.description = <<~DESC
    Worktreegroup is a command-line tool that executes Git worktree operations across 
    multiple repositories simultaneously. It provides add, list, remove, and prune 
    commands that work on all Git repositories found in the current directory, making 
    it easy to manage worktrees across multiple projects at once.
  DESC
  spec.homepage = "https://github.com/nasustim/worktreegroup-rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nasustim/worktreegroup-rb"
  spec.metadata["bug_tracker_uri"] = "https://github.com/nasustim/worktreegroup-rb/issues"
  spec.metadata["documentation_uri"] = "https://github.com/nasustim/worktreegroup-rb#readme"
  spec.metadata["changelog_uri"] = "https://github.com/nasustim/worktreegroup-rb/releases"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = ["worktreegroup"]
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.0"
end