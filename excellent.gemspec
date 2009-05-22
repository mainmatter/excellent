# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name    = %q{excellent}
  s.version = '1.3.0'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to?(:required_rubygems_version=)
  s.authors = ['Marco Otte-Witte']
  s.date = %q{2009-05-06}
  s.email = %q{marco.otte-witte@simplabs.com}
  s.executables = ['excellent']
  s.files = ['History.txt', 'README.rdoc', 'VERSION.yml', 'bin/excellent', 'lib/simplabs/excellent/checks/abc_metric_method_check.rb', 'lib/simplabs/excellent/checks/assignment_in_conditional_check.rb', 'lib/simplabs/excellent/checks/base.rb', 'lib/simplabs/excellent/checks/case_missing_else_check.rb', 'lib/simplabs/excellent/checks/class_line_count_check.rb', 'lib/simplabs/excellent/checks/class_name_check.rb', 'lib/simplabs/excellent/checks/control_coupling_check.rb', 'lib/simplabs/excellent/checks/cyclomatic_complexity_block_check.rb', 'lib/simplabs/excellent/checks/cyclomatic_complexity_check.rb', 'lib/simplabs/excellent/checks/cyclomatic_complexity_method_check.rb', 'lib/simplabs/excellent/checks/duplication_check.rb', 'lib/simplabs/excellent/checks/empty_rescue_body_check.rb', 'lib/simplabs/excellent/checks/flog_block_check.rb', 'lib/simplabs/excellent/checks/flog_check.rb', 'lib/simplabs/excellent/checks/flog_class_check.rb', 'lib/simplabs/excellent/checks/flog_method_check.rb', 'lib/simplabs/excellent/checks/for_loop_check.rb', 'lib/simplabs/excellent/checks/line_count_check.rb', 'lib/simplabs/excellent/checks/method_line_count_check.rb', 'lib/simplabs/excellent/checks/method_name_check.rb', 'lib/simplabs/excellent/checks/module_line_count_check.rb', 'lib/simplabs/excellent/checks/module_name_check.rb', 'lib/simplabs/excellent/checks/name_check.rb', 'lib/simplabs/excellent/checks/nested_iterators_check.rb', 'lib/simplabs/excellent/checks/parameter_number_check.rb', 'lib/simplabs/excellent/checks/rails/attr_accessible_check.rb', 'lib/simplabs/excellent/checks/rails/attr_protected_check.rb', 'lib/simplabs/excellent/checks/rails.rb', 'lib/simplabs/excellent/checks/singleton_variable_check.rb', 'lib/simplabs/excellent/checks.rb', 'lib/simplabs/excellent/extensions/sexp.rb', 'lib/simplabs/excellent/extensions/string.rb', 'lib/simplabs/excellent/parsing/abc_measure.rb', 'lib/simplabs/excellent/parsing/block_context.rb', 'lib/simplabs/excellent/parsing/call_context.rb', 'lib/simplabs/excellent/parsing/case_context.rb', 'lib/simplabs/excellent/parsing/class_context.rb', 'lib/simplabs/excellent/parsing/code_processor.rb', 'lib/simplabs/excellent/parsing/conditional_context.rb', 'lib/simplabs/excellent/parsing/cvar_context.rb', 'lib/simplabs/excellent/parsing/cyclomatic_complexity_measure.rb', 'lib/simplabs/excellent/parsing/flog_measure.rb', 'lib/simplabs/excellent/parsing/for_loop_context.rb', 'lib/simplabs/excellent/parsing/if_context.rb', 'lib/simplabs/excellent/parsing/method_context.rb', 'lib/simplabs/excellent/parsing/module_context.rb', 'lib/simplabs/excellent/parsing/parser.rb', 'lib/simplabs/excellent/parsing/resbody_context.rb', 'lib/simplabs/excellent/parsing/scopeable.rb', 'lib/simplabs/excellent/parsing/sexp_context.rb', 'lib/simplabs/excellent/parsing/singleton_method_context.rb', 'lib/simplabs/excellent/parsing/until_context.rb', 'lib/simplabs/excellent/parsing/while_context.rb', 'lib/simplabs/excellent/parsing.rb', 'lib/simplabs/excellent/runner.rb', 'lib/simplabs/excellent/warning.rb', 'lib/simplabs/excellent.rb', 'spec/checks/abc_metric_method_check_spec.rb', 'spec/checks/assignment_in_conditional_check_spec.rb', 'spec/checks/case_missing_else_check_spec.rb', 'spec/checks/class_line_count_check_spec.rb', 'spec/checks/class_name_check_spec.rb', 'spec/checks/control_coupling_check_spec.rb', 'spec/checks/cyclomatic_complexity_block_check_spec.rb', 'spec/checks/cyclomatic_complexity_method_check_spec.rb', 'spec/checks/duplication_check_spec.rb', 'spec/checks/empty_rescue_body_check_spec.rb', 'spec/checks/flog_block_check_spec.rb', 'spec/checks/flog_class_check_spec.rb', 'spec/checks/flog_method_check_spec.rb', 'spec/checks/for_loop_check_spec.rb', 'spec/checks/method_line_count_check_spec.rb', 'spec/checks/method_name_check_spec.rb', 'spec/checks/module_line_count_check_spec.rb', 'spec/checks/module_name_check_spec.rb', 'spec/checks/nested_iterators_check_spec.rb', 'spec/checks/parameter_number_check_spec.rb', 'spec/checks/rails/attr_accessible_check_spec.rb', 'spec/checks/rails/attr_protected_check_spec.rb', 'spec/checks/singleton_variable_check_spec.rb', 'spec/extensions/string_spec.rb', 'spec/spec_helper.rb']
  s.has_rdoc = true
  s.homepage = %q{http://github.com/simplabs/excellent}
  s.rdoc_options = ['--inline-source', '--charset=UTF-8']
  s.require_paths = ['lib']
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Source Code analysis gem for Ruby and Rails}

  if s.respond_to?(:specification_version) then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby_parser>, ['>= 2.0'])
      s.add_runtime_dependency(%q<sexp_processor>, ['>= 3.0'])
    else
      s.add_dependency(%q<ruby_parser>, ['>= 2.0'])
      s.add_dependency(%q<sexp_processor>, ['>= 3.0'])
    end
  else
    s.add_dependency(%q<ruby_parser>, ['>= 2.0'])
    s.add_dependency(%q<sexp_processor>, ['>= 3.0'])
  end

end
