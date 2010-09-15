# encoding: utf-8

class User
  include CountableAttributes
  include Achievable
  
  def initialize(name)
    @name = name
    @achievements = {}
    @repos = []
  end
  
  attr_reader :name, :achievements, :repos
  
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
end
