# encoding: utf-8

class Repo
  include CountableAttributes
  include Achievable
  
  def initialize(user, name, original_repo = nil)
    @user = user
    @name = name
    @achievements = {}
    @commits_count = 0
    if original_repo
      @fork = true
      @name = "Fork of #{original_repo.name}"
      @commits_count = original_repo.commits_count
    end
  end
  
  attr_reader :user, :name, :achievements, :commits_count
  
  def push(options={})
    if options[:commit]
      @commits_count += options[:commit]
      achieve("Committer", StaticAchievement,
              :commits_count, [0,1,50,1_000,50_000])
    end
  end
  
  def fork?
    !!@fork
  end
end
