require 'helper'

class UserTest < MiniTest::Unit::TestCase
  def test_initailization_ignores_unknown_attributes
    refute_includes User.new(:foo => 'bar').instance_variables, :@foo
  end

  def test_initailization_sets_userid_if_userID_attribute_provided
    assert_includes User.new(:userID => '123').instance_variables, :@userid
  end

  def test_initailization_does_not_set_userid_if_userUD_not_provided
    refute_includes User.new.instance_variables, :@userid
  end
end
