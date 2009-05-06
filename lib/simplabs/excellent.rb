require 'simplabs/excellent/checks'
require 'simplabs/excellent/core'
require 'rubygems'
require 'sexp'

module Excellent

  VERSION = '1.0.0'

end

Sexp.send(:include, Simplabs::Excellent::Core::VisitableSexp)
