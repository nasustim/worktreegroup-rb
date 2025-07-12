# frozen_string_literal: true

require "spec_helper"

RSpec.describe Worktreegroup::CLI do
  describe "#hello" do
    it "displays hello message" do
      expect { described_class.start(["hello"]) }.to output("hello\n").to_stdout
    end

    it "displays hello message as default command" do
      expect { described_class.start([]) }.to output("hello\n").to_stdout
    end
  end

  describe "#version" do
    it "displays the version" do
      expect { described_class.start(["version"]) }.to output("#{Worktreegroup::VERSION}\n").to_stdout
    end
  end

  describe "#add" do
    let(:cli) { described_class.new }

    before do
      allow(cli).to receive(:handle_error) { |msg| puts msg }
    end

    context "when no arguments provided" do
      it "displays error message and exits" do
        expect(cli).to receive(:handle_error).with("Error: Please provide arguments for git worktree add")
        expect { cli.add }.to output("Error: Please provide arguments for git worktree add\n").to_stdout
      end
    end

    context "when no git repositories found" do
      before do
        allow(cli).to receive(:find_git_repositories).and_return([])
      end

      it "displays error message and exits" do
        expect(cli).to receive(:handle_error).with("No git repositories found in current directory")
        expect { cli.add("some-path") }.to output("No git repositories found in current directory\n").to_stdout
      end
    end

    context "when git repositories found" do
      before do
        allow(cli).to receive(:find_git_repositories).and_return(["repo1", "repo2"])
        allow(cli).to receive(:execute_worktree_add).and_return(true)
      end

      it "processes all repositories successfully" do
        output = <<~OUTPUT
          Found 2 git repository(ies):
            - repo1
            - repo2

          Processing repo1...
            ✓ Success
          Processing repo2...
            ✓ Success

          Completed: 2/2 repositories processed successfully
        OUTPUT

        expect { cli.add("some-path") }.to output(output).to_stdout
      end
    end

    context "when some repositories fail" do
      before do
        allow(cli).to receive(:find_git_repositories).and_return(["repo1", "repo2"])
        allow(cli).to receive(:execute_worktree_add).with("repo1", ["some-path"]).and_return(true)
        allow(cli).to receive(:execute_worktree_add).with("repo2", ["some-path"]).and_return(false)
      end

      it "shows mixed results" do
        output = <<~OUTPUT
          Found 2 git repository(ies):
            - repo1
            - repo2

          Processing repo1...
            ✓ Success
          Processing repo2...
            ✗ Failed

          Completed: 1/2 repositories processed successfully
        OUTPUT

        expect { cli.add("some-path") }.to output(output).to_stdout
      end
    end
  end
end