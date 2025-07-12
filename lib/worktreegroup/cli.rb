# frozen_string_literal: true

require "thor"

module Worktreegroup
  class CLI < Thor
    default_task :hello

    desc "hello", "Show greeting message"
    def hello
      puts "hello"
    end

    desc "version", "Show version"
    def version
      puts VERSION
    end
  end
end