require 'bundler'
require 'rake/clean'

require 'rspec/core/rake_task'

require 'cucumber'
require 'cucumber/rake/task'
gem 'rdoc' # we need the installed RDoc gem, not the system one
require 'rdoc/task'

require 'pathname'

require File.expand_path('../lib/twoffein-client/version', __FILE__)
require File.expand_path('../lib/twoffein-client/env', __FILE__)

include Rake::DSL

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |t|
  # Put spec opts in a file named .rspec in root
end

CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format pretty --no-source -x"
  t.fork = false
end

Rake::RDocTask.new do |rd|
  #rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
end

require 'rake/version_task'
Rake::VersionTask.new

task :default => [:spec,:features]

module Erb
  require 'erb'

  def self.rm_basename_ext file, extension
    path = Pathname.new(file)
    path.basename.sub(/\.#{extension}$/, '').to_s
  end

  def self.target_of file
    rm_basename_ext(file, "erb")
  end

  def self.generate_file file, options={}
    target = target_of file
    puts "generating #{target}"
    return if options[:noop]

    File.open(target, 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  rescue Interrupt
  end
end

desc "Generate README.md"
task :gen_readme do
  Erb::generate_file "README.md.erb"
end
