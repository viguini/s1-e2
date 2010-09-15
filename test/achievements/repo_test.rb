# encoding: utf-8

require File.join(File.expand_path(File.dirname(__FILE__)), "..", "test_helper")

class RepoTest < Test::Unit::TestCase
  
  describe "new repo" do
    setup do
      @repo = Repo.new(User.new("User"), "Repo")
    end
    
    test "has an user" do
      assert @repo.user
    end
    
    test "has a name" do
      assert @repo.name
    end
    
    test "has one achievement" do
      assert_equal 1, @repo.achievements_count
    end
    
    test "starts as master issue cleaner" do
      assert_match /Master/, @repo.achievements["Issues Cleaner"].to_s
    end
    
    test "has no commits" do
      assert_equal 0, @repo.commits_count
    end
  end
  
  describe "forked repos" do
    setup do
      @base_repo = Repo.new(User.new("User"), "Base Repo")
      @base_repo.push_commits(100)
      @fork = Repo.new(User.new("Forker"), "", @base_repo)
    end
    
    test "bring the base repo name" do
      assert_match Regexp.new(@base_repo.name), @fork.name
    end
    
    test "are named as forks" do
      assert_match /Fork/, @fork.name
    end
    
    test "behaves as forks" do
      assert @fork.fork?
    end
    
    test "copy the base repo commits count" do
      assert_equal @fork.commits_count, @base_repo.commits_count
    end
    
    test "has the same number of achievements" do
      assert_not_equal @base_repo.achievements_count, @fork.achievements_count
    end
    
    test "duplicates the achievements" do
      assert_not_equal @base_repo.achievements["Committer"],
          @fork.achievements["Committer"]
    end
  end

  test "push commits" do
    @repo = Repo.new(User.new("User"), "Repo")
    @repo.push_commits(20)
    assert_equal 20, @repo.commits_count
  end
  
  test "receive an issue" do
    @repo = Repo.new(User.new("User"), "Repo")
    @repo.receive_issue(1)
    assert_equal 1, @repo.issues_count
  end
  
  test "clear an issue" do
    @repo = Repo.new(User.new("User"), "Repo")
    @repo.receive_issue(10)
    @repo.clear_issue(2)
    assert_equal 8, @repo.issues_count
  end
  
  describe "earn achievements" do
    test "when commits are pushed" do
      @repo = Repo.new(User.new("User"), "Repo")
      @repo.push_commits(100)
      assert_equal 2, @repo.achievements_count
    end
  end
  
  describe "achievements level down" do
    test "when receives an issue" do
      @repo = Repo.new(User.new("User"), "Repo")
      @repo.receive_issue(1)
      assert_match /Advanced/, @repo.achievements["Issues Cleaner"].to_s
    end
  end
end
