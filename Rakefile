require "rake/testtask"
require "rubocop/rake_task"

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
  t.libs << "test"
end

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ["--force-exclusion"]
end

task default: [:test, :rubocop]
