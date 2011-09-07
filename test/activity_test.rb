require 'helper'

class ActivityTest < MiniTest::Unit::TestCase
  def test_initailization_ignores_unknown_attributes
    refute_includes Activity.new(:foo => 'bar').instance_variables, :@foo
  end

  def test_id_is_nil_when_no_uri
    assert_nil Activity.new.id
  end
end
