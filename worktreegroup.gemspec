# frozen_string_literal: true

require_relative "lib/worktreegroup/version"

Gem::Specification.new do |spec|
  spec.name = "worktreegroup"
  spec.version = Worktreegroup::VERSION
  spec.authors = ["Your Name"]
  spec.email = ["your.email@example.com"]

  spec.summary = "A CLI tool for managing Git worktree groups"
  spec.description = "Command line tool to help organize and manage Git worktrees in groups"
  spec.homepage = "https://github.com/nasustim/worktreegroup-rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nasustim/worktreegroup-rb"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.0"
end