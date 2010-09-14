# encoding: utf-8

require File.join(File.expand_path(File.dirname(__FILE__)), "..", "test_helper")

class RepoTest < Test::Unit::TestCase
  
  describe "new repo" do
    setup do
      @repo = Repo.new("User", "Repo")
    end
    
    test "has an user" do
      assert @repo.user
    end
    
    test "has a name" do
      assert @repo.name
    end
    
    test "has no achievements" do
      assert_equal 0, @repo.achievements_count
    end
    
    test "has no commits" do
      assert_equal 0, @repo.commits_count
    end
  end
  
  test "can push commits" do
    @repo = Repo.new("User", "Repo")
    @repo.push(:commits => 20)
    assert_equal 20, @repo.commits_count
  end
  
  describe "earn achievements" do
    test "when commits are pushed" do
      @repo = Repo.new("User", "Repo")
      @repo.push(:commits => 1)
      assert_equal 1, @repo.achievements_count
    end
  end
end
