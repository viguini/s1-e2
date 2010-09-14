# encoding: utf-8

class User
  def initialize
    @achievements = []
    @repos = []
  end
  
  attr_reader :achievements, :repos
  
  def create_repo(name)
    @repos << Repo.new(self, name)
  end
  
  def method_missing(id, *args, &block)
    case(id.to_s)
    when /(.*)_count$/
      send($1).count
    else
      super
    end
  end
end
