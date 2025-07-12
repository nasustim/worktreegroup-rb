# frozen_string_literal: true

RSpec.describe Worktreegroup do
  it "has a version number" do
    expect(Worktreegroup::VERSION).not_to be nil
  end

  describe "::Error" do
    it "is a StandardError" do
      expect(Worktreegroup::Error.new).to be_a(StandardError)
    end
  end
end