require 'bundler'
require 'rake/clean'

require 'rspec/core/rake_task'

require 'cucumber'
require 'cucumber/rake/task'
gem 'rdoc' # we need the installed RDoc gem, not the system one
require 'rdoc/task'
require 'jeweler'

require 'erb'
require 'pathname'

require File.expand_path('../lib/twoffein-client/version', __FILE__)

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
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
end

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name          = "twoffein-client"
  gem.authors       = ["DSIW"]
  gem.email         = ["dsiw@dsiw-it.de"]
  gem.description   = %q{Client for twoffein.de API}
  gem.summary       = %q{Client for twoffein.de API}
  gem.homepage      = "https://github.com/DSIW/twoffein-client"
  #gem.version       = Twoffein::Client::VERSION
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('aruba')
  gem.add_development_dependency('rake','~> 0.9.2')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('webmock')
  gem.add_development_dependency('vcr')
  gem.add_dependency('methadone', '~>1.0.0.rc4')
  gem.add_dependency('gli')
end
Jeweler::RubygemsDotOrgTasks.new

task :default => [:spec,:features]

def rm_basename_ext file, extension
  path = Pathname.new(file)
  path.basename.sub(/\.#{extension}$/, '').to_s
end

def target_of file
  rm_basename_ext(file, "erb")
end

def generate_file file, options={}
  target = target_of file
  puts "generating #{target}"
  return if options[:noop]

  File.open(target, 'w') do |new_file|
    new_file.write ERB.new(File.read(file)).result(binding)
  end
rescue Interrupt
end

desc "Hook our dotfiles into system-standard positions."
task :gen_readme do
  generate_file "README.md.erb"
end
