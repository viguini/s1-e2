# encoding: utf-8

class Repo
  include CountableAttributes
  include Achievable
  
  def initialize(user, name, original_repo = nil)
    @user = user
    @name = name
    @achievements = {}
    @commits_count = 0
    
    @issues_count = 0
    clear_issue(0)
    
    if original_repo
      @fork = true
      @name = "Fork of #{original_repo.name}"
      @commits_count = original_repo.commits_count
      @issues_count = original_repo.issues_count
    end
  end
  
  attr_reader :user, :name, :achievements, :commits_count, :issues_count
  
  def push_commits(count)
    @commits_count += count
    achieve("Committer", StaticAchievement,
            :commits_count, [0,1,50,1_000,50_000])
  end

  def receive_issue(count)
    @issues_count += count
    
    achieve_issues_cleaner
  end
  
  def clear_issue(count)
    @issues_count -= count
    @issues_count = 0 if @issues_count < 0
    
    achieve_issues_cleaner
  end
  
  def fork?
    !!@fork
  end
  
private
  def achieve_issues_cleaner
    achieve("Issues Cleaner", DescendingStaticAchievement,
            :issues_count, [20,10,5,1,0])
  end
end
