# encoding: utf-8

require "rubygems"
require "bundler/setup"

$LOAD_PATH.unshift(File.dirname(__FILE__))

module CountableAttributes

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

module Achievable

private
  def achieve(name, klass, target, stages)
    @achievements[name] ||= klass.new(name, self, target, stages)
    @achievements[name].update!
  end
end

require "achievements/user.rb"
require "achievements/repo.rb"
require "achievements/achievement.rb"
