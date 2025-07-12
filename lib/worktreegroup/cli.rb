# frozen_string_literal: true

require "thor"

module Worktreegroup
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    default_task :hello

    desc "hello", "Show greeting message"
    def hello
      puts "hello"
    end

    desc "version", "Show version"
    def version
      puts VERSION
    end

    desc "add *ARGS", "Add worktree to all git repositories in current directory"
    def add(*args)
      return handle_error("Error: Please provide arguments for git worktree add") if args.empty?

      git_repos = find_git_repositories
      return handle_error("No git repositories found in current directory") if git_repos.empty?

      puts "Found #{git_repos.size} git repository(ies):"
      git_repos.each { |repo| puts "  - #{repo}" }
      puts

      success_count = 0
      git_repos.each do |repo|
        puts "Processing #{repo}..."
        if execute_worktree_add(repo, args)
          success_count += 1
          puts "  ✓ Success"
        else
          puts "  ✗ Failed"
        end
      end

      puts "\nCompleted: #{success_count}/#{git_repos.size} repositories processed successfully"
    end

    private

    def handle_error(message)
      puts message
      exit 1
    end

    def find_git_repositories
      Dir.glob("*/").select do |dir|
        File.directory?(File.join(dir, ".git"))
      end.map { |dir| dir.chomp("/") }
    end

    def execute_worktree_add(repo_dir, args)
      Dir.chdir(repo_dir) do
        command = ["git", "worktree", "add"] + args
        system(*command, out: File::NULL, err: File::NULL)
      end
    rescue => e
      false
    end
  end
end