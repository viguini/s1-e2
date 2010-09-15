# encoding: utf-8

require File.join(File.expand_path(File.dirname(__FILE__)), "..", "test_helper")

class UserTest < Test::Unit::TestCase
  describe "new user" do
    setup do
      @user = User.new("User")
    end
    
    test "has a name" do
      assert @user.name
    end
    
    test "has no achievements" do
      assert_equal 0, @user.achievements_count
    end
    
    test "has no repos" do
      assert_equal 0, @user.repos_count
    end
  end
  
  test "create a repo" do
    @user = User.new("User")
    @user.create_repo("Repo")
    assert_equal 1, @user.repos_count
  end
  
  test "fork a repo" do
    another_repo = Repo.new(User.new("Another"), "Another Repo")
    @user = User.new("User")
    @user.fork_repo(another_repo)
    assert_equal 1, @user.forks_count
  end
  
  test "receive a follower" do
    @user = User.new("User")
    @user.receive(:follower => 1)
    assert_equal 1, @user.followers_count
  end
  
  test "lose a follower" do
    @user = User.new("User")
    @user.receive(:follower => 1)
    @user.lose_follower(1)
    assert_equal 0, @user.followers_count
  end
  
  describe "earn achievements" do
    test "when creates a repo" do
      @user = User.new("User")
      @user.create_repo("Repo")
      assert_equal 1, @user.achievements_count
    end
    
    test "when forks a repo" do
      another_repo = Repo.new(User.new("Another"), "Another Repo")
      @user = User.new("User")
      @user.fork_repo(another_repo)
      assert_equal 1, @user.achievements_count
    end
    
    test "when receives followers" do
      @user = User.new("User")
      @user.receive(:follower => 1)
      assert_equal 1, @user.achievements_count
    end
  end
  
  describe "achievements level down" do
    test "when loses followers" do
      @user = User.new("User")
      @user.receive(:follower => 10)
      assert_match /Intermediate/, @user.achievements["Followed"].to_s
      
      @user.lose_follower(5)
      assert_match /Novice/, @user.achievements["Followed"].to_s
    end
  end
end
