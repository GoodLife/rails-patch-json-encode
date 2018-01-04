require "bundler/gem_tasks"

task default: :test

desc "Benchmark"
task :benchmark do
  require_relative 'benchmark/base_classes'
end

### Test
require "rake/testtask"
dir = File.dirname(__FILE__)
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir.glob("#{dir}/test/**/*_test.rb")
  t.warning = true
  t.verbose = true
  t.ruby_opts = ["--dev"] if defined?(JRUBY_VERSION)
end
