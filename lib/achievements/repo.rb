# encoding: utf-8

class Repo
  def initialize(user, name)
    @user = user
    @name = name
    @achievements = []
    @commits_count = 0
  end
  
  attr_reader :user, :name, :achievements, :commits_count
  
  
private

  def method_missing(id, *args, &block)
    case(id.to_s)
    when /(.*)_count$/
      send($1).count
    else
      super
    end
  end
end
