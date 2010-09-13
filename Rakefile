require "rubygems"
require "rake"
require "rake/testtask"

task :default => [:test]

desc "Run all tests"
Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = Dir["test/**/*_test.rb"]
  test.verbose = true
end