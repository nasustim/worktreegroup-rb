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

    desc "list", "List Git worktrees"
    def list
      puts "Listing Git worktrees..."
      # TODO: Implement worktree listing functionality
    end

    desc "group COMMAND ...ARGS", "Manage worktree groups"
    subcommand "group", Group

    private

    class Group < Thor
      desc "create NAME", "Create a new worktree group"
      def create(name)
        puts "Creating worktree group: #{name}"
        # TODO: Implement group creation functionality
      end

      desc "list", "List all worktree groups"
      def list
        puts "Listing worktree groups..."
        # TODO: Implement group listing functionality
      end

      desc "add GROUP WORKTREE", "Add worktree to group"
      def add(group, worktree)
        puts "Adding worktree '#{worktree}' to group '#{group}'"
        # TODO: Implement adding worktree to group
      end
    end
  end
end