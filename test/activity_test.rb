require 'helper'

class ActivityTest < MiniTest::Unit::TestCase
  def test_initailization_ignores_unknown_attributes
    refute_match Activity.new(:foo => 'bar').instance_variables, /foo/
  end
end
