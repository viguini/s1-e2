# encoding: utf-8

require File.join(File.expand_path(File.dirname(__FILE__)), "..", "test_helper")

class UserTest < Test::Unit::TestCase
  describe "new user" do
    setup do
      @user = User.new
    end
    
    test "has no achievements" do
      assert_equal 0, @user.achievements_count
    end
    
    test "has no repos" do
      assert_equal 0, @user.repos_count
    end
  end
end
