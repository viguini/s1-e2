# encoding: utf-8

class Achievement
  Classification = %w[Dog Novice Intermediate Advanced Master]
  
  def initialize(name, owner)
    @name = name
    @owner = owner
    @current_stage = 0
    update!
  end
  
  attr_reader :name, :owner
  
  def to_s
    "#{Classification[@current_stage]} #{@name}"
  end
  
  def update!
  end
end

class StaticAchievement < Achievement
  
  def initialize(name, owner, target, stages = [0, 1, 2, 3, 4])
    @target = target
    @stages = stages.freeze
    super(name, owner)
  end
  
  attr_reader :target
  
  def update!
    return if @current_stage == @stages.size - 1
    if @owner.send(@target) >= @stages[@current_stage+1]
      @current_stage += 1
      update!
    end
  end
end

