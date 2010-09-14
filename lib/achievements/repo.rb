# encoding: utf-8

class Repo
  include CountableAttributes
  
  def initialize(user, name)
    @user = user
    @name = name
    @achievements = []
    @commits_count = 0
  end
  
  attr_reader :user, :name, :achievements, :commits_count
end
