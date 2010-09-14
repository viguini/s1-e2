# encoding: utf-8

require File.join(File.expand_path(File.dirname(__FILE__)), "..", "test_helper")

class RepoTest < Test::Unit::TestCase
  describe "new repo" do
    setup do
      @repo = Repo.new(User.new, 'Example')
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
end
