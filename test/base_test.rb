require 'helper'

class UserTest < MiniTest::Unit::TestCase
  def test_initailization_ignores_unknown_attributes
    refute_includes Activity.new('foo' => 'bar').instance_variables, :@foo
  end
end
