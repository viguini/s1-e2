# encoding: utf-8

class Repo
  include CountableAttributes
  include Achievable
  
  def initialize(user, name)
    @user = user
    @name = name
    @achievements = {}
    @commits_count = 0
  end
  
  attr_reader :user, :name, :achievements, :commits_count
  
  def push(options={})
    if options[:commits]
      @commits_count += options[:commits]
      achieve("Committer", StaticAchievement,
              :commits_count, [0,1,50,1_000,50_000])
    end
  end
end
