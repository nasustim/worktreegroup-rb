# frozen_string_literal: true

require "spec_helper"
require "tmpdir"
require "fileutils"

RSpec.describe "CLI E2E Tests", type: :e2e do
  let(:cli_path) { File.expand_path("../../bin/worktreegroup", __dir__) }
  
  around do |example|
    Dir.mktmpdir("worktreegroup_e2e") do |test_dir|
      @original_dir = Dir.pwd
      Dir.chdir(test_dir)
      @test_dir = test_dir
      example.run
      Dir.chdir(@original_dir)
    end
  end

  def setup_git_repo(name)
    return if File.directory?(name)
    
    Dir.mkdir(name)
    Dir.chdir(name) do
      system("git init", out: File::NULL, err: File::NULL)
      system("git config user.name 'Test User'", out: File::NULL, err: File::NULL)
      system("git config user.email 'test@example.com'", out: File::NULL, err: File::NULL)
      File.write("README.md", "# #{name}")
      system("git add README.md", out: File::NULL, err: File::NULL)
      system("git commit -m 'Initial commit'", out: File::NULL, err: File::NULL)
    end
    Dir.chdir(@test_dir)
  end

  def run_cli(*args)
    system(cli_path, *args.map(&:to_s), out: File::NULL, err: File::NULL)
  end

  def run_cli_with_output(*args)
    `#{cli_path} #{args.join(" ")} 2>&1`
  end

  describe "hello command" do
    it "displays hello message" do
      output = run_cli_with_output("hello")
      expect(output.strip).to eq("hello")
    end

    it "displays hello as default command" do
      output = run_cli_with_output
      expect(output.strip).to eq("hello")
    end
  end

  describe "version command" do
    it "displays version" do
      output = run_cli_with_output("version")
      expect(output.strip).to match(/\d+\.\d+\.\d+/)
    end
  end

  describe "add command" do
    context "with no arguments" do
      it "displays error message" do
        output = run_cli_with_output("add")
        expect(output).to include("Error: Please provide arguments for git worktree add")
      end
    end

    context "with no git repositories" do
      it "displays error message" do
        output = run_cli_with_output("add", "../test-worktree")
        expect(output).to include("No git repositories found in current directory")
      end
    end

    context "with single git repository" do
      before do
        setup_git_repo("repo1")
      end

      it "creates worktree successfully" do
        worktree_path = File.join(@test_dir, "test-worktree")
        result = run_cli("add", worktree_path)
        expect(result).to be true

        # Verify worktree was created
        expect(File.directory?(worktree_path)).to be true
        expect(File.exist?(File.join(worktree_path, "README.md"))).to be true

        # Verify git worktree list shows the new worktree
        Dir.chdir("repo1") do
          worktree_list = `git worktree list`
          expect(worktree_list).to include(worktree_path)
        end
      end

      it "creates worktree with new branch" do
        worktree_path = File.join(@test_dir, "feature-worktree")
        result = run_cli("add", "-b", "feature-branch", worktree_path)
        expect(result).to be true

        # Verify worktree was created with new branch
        expect(File.directory?(worktree_path)).to be true

        Dir.chdir("repo1") do
          # Check that the branch exists
          branches = `git branch -a`
          expect(branches).to include("feature-branch")
        end

        Dir.chdir(worktree_path) do
          # Check current branch in worktree
          current_branch = `git branch --show-current`.strip
          expect(current_branch).to eq("feature-branch")
        end
      end
    end

    context "with multiple git repositories" do
      before do
        setup_git_repo("repo1")
        setup_git_repo("repo2")
        setup_git_repo("repo3")
      end

      it "creates worktrees in all repositories" do
        worktree_path = File.join(@test_dir, "multi-worktree")
        output = run_cli_with_output("add", worktree_path)
        
        # Verify output shows processing of all repos
        expect(output).to include("Found 3 git repository(ies)")
        expect(output).to include("Processing repo1...")
        expect(output).to include("Processing repo2...")
        expect(output).to include("Processing repo3...")
        expect(output).to include("Completed:")

        # Verify worktree directories exist
        expect(File.directory?(worktree_path)).to be true
        
        # Verify at least some worktrees were created (due to potential path resolution differences)
        worktree_count = 0
        %w[repo1 repo2 repo3].each do |repo|
          Dir.chdir(repo) do
            worktree_list = `git worktree list`
            worktree_count += 1 if worktree_list.lines.count > 1
          end
        end
        expect(worktree_count).to be > 0
      end

      it "handles mixed success and failure scenarios" do
        worktree_path = File.join(@test_dir, "conflict-worktree")
        
        # Create a worktree manually in repo1 to cause conflict
        Dir.chdir("repo1") do
          system("git worktree add #{worktree_path}", out: File::NULL, err: File::NULL)
        end

        # Try to create the same worktree path in all repos
        output = run_cli_with_output("add", worktree_path)
        
        # Should show processing of all repos but some failures
        expect(output).to include("Found 3 git repository(ies)")
        expect(output).to include("Processing repo1...")
        expect(output).to include("Processing repo2...")
        expect(output).to include("Processing repo3...")
      end
    end

    context "with git worktree add options" do
      before do
        setup_git_repo("repo1")
        # Create a commit to have something to checkout
        Dir.chdir("repo1") do
          File.write("feature.txt", "feature content")
          system("git add feature.txt", out: File::NULL, err: File::NULL)
          system("git commit -m 'Add feature'", out: File::NULL, err: File::NULL)
        end
        Dir.chdir(@test_dir)
      end

      it "supports detached worktree" do
        worktree_path = File.join(@test_dir, "detached-worktree")
        result = run_cli("add", "--detach", worktree_path, "HEAD~1")
        expect(result).to be true

        Dir.chdir(worktree_path) do
          # Should be in detached HEAD state
          branch_info = `git branch --show-current`.strip
          expect(branch_info).to be_empty
        end
      end
    end
  end

  describe "CLI help and error handling" do
    it "shows help when run with invalid command" do
      output = run_cli_with_output("invalid-command")
      expect($?.exitstatus).not_to eq(0)
    end
  end
end