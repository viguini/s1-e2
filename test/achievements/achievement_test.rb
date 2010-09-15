# encoding: utf-8

require File.join(File.expand_path(File.dirname(__FILE__)), "..", "test_helper")

class AchievementTest < Test::Unit::TestCase
  describe "new achievement" do
    setup do
      @achievement = Achievement.new("Githuber", "owner")
    end
    
    test "has an owner" do
      assert @achievement.owner
    end

    test "has a name" do
      assert @achievement.name
      assert_match /Githuber/, @achievement.to_s
    end
    
    test "starts as a dog" do
      assert_match /Dog/, @achievement.to_s
    end
  end
end

class StaticAchievementTest < Test::Unit::TestCase
  describe "new static achievement" do
    setup do
      @achievement = StaticAchievement.new("Commiter", ["commit"], :size)
    end
    
    test "has an owner" do
      assert @achievement.owner
    end
    
    test "has a target" do
      assert @achievement.target
    end
  end
  
  describe "leveling" do
    setup do
      @achievement = StaticAchievement.new("Commiter", ["commit"], :size)
    end
    
    test "with no changes to the owner update does nothing" do
      assert_match /Novice/, @achievement.to_s
      
      @achievement.update!
      assert_match /Novice/, @achievement.to_s
    end
    
    test "up one level" do
      @achievement.owner << "commit"
      @achievement.update!
      assert_match /Intermediate/, @achievement.to_s
    end
    
    test "up two levels at once" do
      2.times { @achievement.owner << "commit" }
      @achievement.update!
      assert_match /Advanced/, @achievement.to_s
    end
    
    test "cannot level up past the last level" do
      3.times { @achievement.owner << "commit" }
      @achievement.update!
      assert_match /Master/, @achievement.to_s
      
      @achievement.owner << "commit"
      @achievement.update!
      assert_match /Master/, @achievement.to_s
    end
    
    test "down one level" do
      3.times { @achievement.owner << "commit" }
      @achievement.update!
      assert_match /Master/, @achievement.to_s
      
      @achievement.owner.pop
      @achievement.update!
      assert_match /Advanced/, @achievement.to_s
    end

    test "down two levels at once" do
      3.times { @achievement.owner << "commit" }
      @achievement.update!
      assert_match /Master/, @achievement.to_s
      
      2.times { @achievement.owner.pop }
      @achievement.update!
      assert_match /Intermediate/, @achievement.to_s
    end

    test "cannot level down beneath the first level" do
      @achievement = StaticAchievement.new("Commiter", ["commit"],
          :size, [2,3,4,5,6])
      2.times { @achievement.owner << "commit" }
      @achievement.update!
      assert_match /Novice/, @achievement.to_s
      
      3.times { @achievement.owner.pop }
      @achievement.update!
      assert_match /Dog/, @achievement.to_s
    end
  end
end

class DescendingStaticAchievementTest < Test::Unit::TestCase
  
  describe "new descending static achievement" do
    setup do
      @achievement = DescendingStaticAchievement.new("Issues Cleaner",
          [], :size)
    end
    
    test "starts as a master" do
      assert_match /Master/, @achievement.to_s
    end
  end
end

class PercentageAchievementTest < Test::Unit::TestCase
  test "create a new class inheritting from percentage achievement" do
    @most_followed = PercentageAchievement.create(20, :size)
    assert_equal PercentageAchievement, @most_followed.superclass
    
    assert_equal 20,    @most_followed.instance.percentage
    assert_equal :size, @most_followed.instance.target
  end
  
  describe "new descendant of percentage achievement" do
    setup do
      @most_followed = PercentageAchievement.create(20, :size).instance
      @users = [[1], [1,2,3,4,5], [1,2], [1,2,3,4], [1,2,3]]
    end
    
    test "hook candidates" do
      @most_followed.register(@users[0])
      assert @most_followed.candidates.include?(@users[0])
    end
    
    test "select achievers rounding down" do
      @most_followed.register(@users[0])
      assert_false @most_followed.achievers.include?(@users[0])
      
      6.times { @most_followed.register(["follower"]) }
      assert_equal 1, @most_followed.achievers.size
    end
    
    test "select top achievers based on target" do
      @users.each {|u| @most_followed.register(u) }
      assert_equal @users[1], @most_followed.achievers.first
    end
  end
end
