require 'simplabs/excellent/checks'
require 'simplabs/excellent/core'
require 'rubygems'
require 'sexp'

module Excellent

  VERSION = '1.0.1'

end

Sexp.class_eval do

  def children
    sexp_body.select {|each| each.is_a?(Sexp) }
  end

end
