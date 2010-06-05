require 'rubygems'
require 'rake/clean'
require 'spec/rake/spectask'

desc 'Default: run specs.'
task :default => :spec

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name = 'remit2'
    gem.summary = 'An API for using the Amazon Flexible Payment Service (FPS) - updated for version 2008-09-17 of the API.'
    gem.email = 'micah@peachshake.com'
    gem.homepage = 'http://github.com/micahwedemeyer/remit2'
    gem.authors = ['Micah Wedemeyer', 'Tyler Hunt']
    gem.rubyforge_project = 'remit2'
    gem.platform           = Gem::Platform::RUBY
    gem.files              = FileList['{bin,lib}/**/*'].to_a
    gem.require_path       = 'lib'
    gem.test_files         = FileList['{spec}/**/{*spec.rb,*helper.rb}'].to_a
    gem.has_rdoc           = true
    gem.extra_rdoc_files   = ['README.markdown', 'LICENSE']

    gem.add_dependency('relax', '~> 0.0.7')
  end
rescue LoadError
  puts 'Jeweler not available. Install it with: gem install jeweler'
end

task :spec do
  Rake::Task["spec:units"].invoke
end

namespace :spec do
  desc "Run unit specs."
  Spec::Rake::SpecTask.new(:units) do |t|
    t.spec_opts   = ['--colour --format progress --loadby mtime --reverse --backtrace']
    t.spec_files  = FileList['spec/units/**/*_spec.rb']
  end

  desc "Run integration specs. Requires AWS_ACCESS_KEY and AWS_SECRET_KEY."
  Spec::Rake::SpecTask.new(:integrations) do |t|
    t.spec_opts   = ['--colour --format progress --loadby mtime --reverse']
    t.spec_files  = FileList['spec/integrations/**/*_spec.rb']
  end
end

Spec::Rake::SpecTask.new(:doc) do |t|
  t.spec_opts   = ['--format specdoc --dry-run --colour']
  t.spec_files  = FileList['spec/**/*_spec.rb']
end
