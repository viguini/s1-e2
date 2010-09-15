# encoding: utf-8

class User
  include CountableAttributes
  include Achievable
  
  def initialize(name)
    @name = name
    @achievements = {}
    @repos = []
    @followers_count = 0
  end
  
  attr_reader :name, :achievements, :repos, :followers_count
  
  def create_repo(name)
    @repos << Repo.new(self, name)
    achieve("Repo Creater", StaticAchievement, :repos_count, [0,1,5,10,25])
  end
  
  def fork_repo(repo)
    @repos << Repo.new(self, repo.name, repo)
    achieve("Forker", StaticAchievement, :forks_count, [0,1,5,10,25])
  end
  
  def forks_count
    @repos.select(&:fork?).count
  end
  
  def receive_follower(count)
    @followers_count += count
    achieve_followed
  end
  
  def lose_follower(count)
    @followers_count -= count
    @followers_count = 0 if @followers_count < 0
    achieve_followed
  end
  
private
  def achieve_followed
    achieve("Followed", StaticAchievement,
        :followers_count, [0,1,10,50,250])
  end
end
