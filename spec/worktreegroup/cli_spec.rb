# frozen_string_literal: true

require "spec_helper"

RSpec.describe Worktreegroup::CLI do
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