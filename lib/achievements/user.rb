# encoding: utf-8

class User
  include CountableAttributes
  
  def initialize(name)
    @name = name
    @achievements = {}
    @repos = []
  end
  
  attr_reader :name, :achievements, :repos
  
  def create_repo(name)
    @repos << Repo.new(self, name)
    achieve("Repo Owner", StaticAchievement, :repos_count, [0,1,5,10,25])
  end

private

  def achieve(name, klass, target, stages)
    @achievements[name] ||= klass.new(name, self, target, stages)
    @achievements[name].update!
  end
end
