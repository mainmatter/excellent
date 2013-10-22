require 'spec_helper'

describe 'issue #29' do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new([:'Rails::ValidationsCheck' => {}])
  end

  it 'is fixed' do
    validators = [
      'validate :must_be_friends',
      'validates :terms, acceptance: true',
      'validates! :name, presence: true',
      'validates_each :first_name, :last_name, allow_blank: true do |record, attr, value|
         record.errors.add attr, "starts with z." if value.to_s[0] == z
       end',
      'validates_with MyValidator'
    ]
    validators.each do |validator|
      code = <<-END
        class Model < ActiveRecord::Base
          #{validator}
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end
  end

end
