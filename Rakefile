$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'hoe'
require 'rake'
require 'spec/rake/spectask'
require 'simplabs/excellent'
require 'jeweler'
require 'pathname'

Jeweler::Tasks.new do |s|
  s.name     = 'excellent'
  s.summary  = 'Source code analysis gem'
  s.version  = '1.0.0'
  s.email    = 'marco.otte-witte@simplabs.com'
  s.homepage = 'http://github.com/marcoow/excellent'
  s.authors  = ['originally by Marty Andrews (marty@cogentconsulting.com.au)', 'modifications by Marco Otte-Witte (http://simplabs.com)']
end

Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts << '--color'
  t.spec_opts << '--format=html:doc/spec.html'
  t.spec_opts << '--format=specdoc'
  t.rcov_opts << '--exclude "gems/*,spec/*,init.rb"'
  t.rcov       = true
  t.rcov_dir   = 'doc/coverage'
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc 'Generate documentation for the Excellent gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'Excellent'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Run Excellent against all source files'
task :excellent do
  puts `bin/excellent "lib/**/*.rb"`
end

task :default => :spec
