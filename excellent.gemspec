# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = %q{excellent}
  s.description = 'Excellent finds the nasty lines in your code. It implements a comprehensive set of checks for possibly buggy parts of your app that would otherwise make it into your repo and eventually to the production server.'
  s.summary     = %q{Source Code analysis gem for Ruby and Rails}
  s.version     = '2.0.0'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to?(:required_rubygems_version=)
  s.authors                   = ['Marco Otte-Witte']
  s.date                      = %q{2009-08-05}
  s.email                     = %q{marco.otte-witte@simplabs.com}
  s.executables               = ['excellent']
  s.files                     = Dir['MIT-LICENSE', 'README.md', 'History.txt', 'bin/**/*', 'lib/**/*']
  s.has_rdoc                  = true
  s.homepage                  = %q{http://github.com/simplabs/excellent}
  s.rdoc_options              = ['--inline-source', '--charset=UTF-8']
  s.require_paths             = ['lib']
  s.rubygems_version          = %q{1.3.0}

  if s.respond_to?(:specification_version) then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby_parser>, ['>= 3.0'])
      s.add_runtime_dependency(%q<sexp_processor>, ['>= 4.0'])
    else
      s.add_dependency(%q<ruby_parser>, ['>= 3.0'])
      s.add_dependency(%q<sexp_processor>, ['>= 4.0'])
    end
  else
    s.add_dependency(%q<ruby_parser>, ['>= 3.0'])
    s.add_dependency(%q<sexp_processor>, ['>= 4.0'])
  end

end
