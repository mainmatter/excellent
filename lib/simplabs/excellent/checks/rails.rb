module Simplabs

  module Excellent

    module Checks

      module Rails #:nodoc:
      end

    end

  end

end

require 'simplabs/excellent/checks/rails/attr_accessible_check'
require 'simplabs/excellent/checks/rails/attr_protected_check'
require 'simplabs/excellent/checks/rails/instance_var_in_partial_check'
require 'simplabs/excellent/checks/rails/validations_check'
require 'simplabs/excellent/checks/rails/params_hash_in_view_check'
require 'simplabs/excellent/checks/rails/session_hash_in_view_check'
