$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'hoe'
require 'rake'
require 'spec/rake/spectask'
require 'simplabs/excellent/rake'
require 'jeweler'
require 'pathname'

Jeweler::Tasks.new do |s|
  s.name     = 'excellent'
  s.summary  = 'Source code analysis gem'
  s.version  = '1.0.0'
  s.email    = 'marco.otte-witte@simplabs.com'
  s.homepage = 'http://github.com/marcoow/excellent'
  s.authors  = ['Marco Otte-Witte (http://simplabs.com), based on roodi, reek and flog.']
end

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts << '--color'
  t.spec_opts << '--format=html:doc/spec.html'
  t.spec_opts << '--format=specdoc'
  t.rcov_opts << '--exclude "gems/*,spec/*,init.rb"'
  t.rcov       = true
  t.rcov_dir   = 'doc/coverage'
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc 'Generate documentation for the Excellent gem.'
Rake::RDocTask.new(:rdoc) do |t|
  t.rdoc_dir = 'doc'
  t.title    = 'Excellent'
  t.options << '--line-numbers' << '--inline-source'
  t.rdoc_files.include('README.rdoc')
  t.rdoc_files.include('lib/**/*.rb')
end

desc 'Analyse the Excellent source with itself.'
Simplabs::Excellent::Rake::ExcellentTask.new(:excellent) do |t|
  t.html  = 'doc/excellent.html'
  t.paths = ['lib']
end
