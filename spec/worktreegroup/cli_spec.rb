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

  describe "#list" do
    it "displays listing message" do
      expect { described_class.start(["list"]) }.to output("Listing Git worktrees...\n").to_stdout
    end
  end
end