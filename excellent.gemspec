# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name    = %q{excellent}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ['Marty Andrews', 'Marco Otte-Witte']
  s.date = %q{2009-05-06}
  s.email = %q{marco.otte-witte@simplabs.com}
  s.executables = ['excellent']
  s.files = ["History.txt", "Manifest.txt", "README.txt", "VERSION.yml", "bin/roodi", "bin/roodi-describe", "lib/roodi", "lib/roodi/checks", "lib/roodi/checks/abc_metric_method_check.rb", "lib/roodi/checks/assignment_in_conditional_check.rb", "lib/roodi/checks/case_missing_else_check.rb", "lib/roodi/checks/check.rb", "lib/roodi/checks/class_line_count_check.rb", "lib/roodi/checks/class_name_check.rb", "lib/roodi/checks/class_variable_check.rb", "lib/roodi/checks/control_coupling_check.rb", "lib/roodi/checks/cyclomatic_complexity_block_check.rb", "lib/roodi/checks/cyclomatic_complexity_check.rb", "lib/roodi/checks/cyclomatic_complexity_method_check.rb", "lib/roodi/checks/empty_rescue_body_check.rb", "lib/roodi/checks/for_loop_check.rb", "lib/roodi/checks/line_count_check.rb", "lib/roodi/checks/method_line_count_check.rb", "lib/roodi/checks/method_name_check.rb", "lib/roodi/checks/module_line_count_check.rb", "lib/roodi/checks/module_name_check.rb", "lib/roodi/checks/name_check.rb", "lib/roodi/checks/parameter_number_check.rb", "lib/roodi/checks.rb", "lib/roodi/core", "lib/roodi/core/checking_visitor.rb", "lib/roodi/core/error.rb", "lib/roodi/core/extensions", "lib/roodi/core/extensions/underscore.rb", "lib/roodi/core/iterator_visitor.rb", "lib/roodi/core/parse_tree_runner.rb", "lib/roodi/core/parser.rb", "lib/roodi/core/visitable_sexp.rb", "lib/roodi/core.rb", "lib/roodi.rb", "spec/roodi", "spec/roodi/checks", "spec/roodi/checks/abc_metric_method_check_spec.rb", "spec/roodi/checks/assignment_in_conditional_check_spec.rb", "spec/roodi/checks/case_missing_else_check_spec.rb", "spec/roodi/checks/class_line_count_check_spec.rb", "spec/roodi/checks/class_name_check_spec.rb", "spec/roodi/checks/class_variable_check_spec.rb", "spec/roodi/checks/control_coupling_check_spec.rb", "spec/roodi/checks/cyclomatic_complexity_block_check_spec.rb", "spec/roodi/checks/cyclomatic_complexity_method_check_spec.rb", "spec/roodi/checks/empty_rescue_body_check_spec.rb", "spec/roodi/checks/for_loop_check_spec.rb", "spec/roodi/checks/method_line_count_check_spec.rb", "spec/roodi/checks/method_name_check_spec.rb", "spec/roodi/checks/module_line_count_check_spec.rb", "spec/roodi/checks/module_name_check_spec.rb", "spec/roodi/checks/parameter_number_check_spec.rb", "spec/roodi/core", "spec/roodi/core/extensions", "spec/roodi/core/extensions/underscore_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/simplabs/excellent}
  s.rdoc_options = ['--inline-source', '--charset=UTF-8']
  s.require_paths = ['lib']
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Source code analysis gem}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby_parser>, ['>= 2.0'])
    else
      s.add_dependency(%q<ruby_parser>, ['>= 2.0'])
    end
  else
    s.add_dependency(%q<ruby_parser>, ['>= 2.0'])
  end

end
