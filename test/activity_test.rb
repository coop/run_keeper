require 'helper'

class ActivityTest < MiniTest::Unit::TestCase
  def test_initailization_ignores_unknown_attributes
    refute_includes Activity.new('foo' => 'bar').instance_variables, :@foo
  end

  def test_id_is_nil_when_no_uri
    assert_nil Activity.new.id
  end

  def test_id_returns_an_integer_from_uri
    assert_instance_of Fixnum, Activity.new('uri' => '/profile/12345').id
  end

  def test_id_returns_uri_id
    assert_equal 12345, Activity.new('uri' => '/profile/12345').id
  end

  def test_start_time_is_UTC
    assert_equal '(GMT+00:00) UTC', Activity.new('start_time' => 'Thu, 1 Sep 2011 17:41:28').start_time.time_zone.to_s
  end

  def test_state_time_is_an_instance_of_time_with_zone
    assert_instance_of ActiveSupport::TimeWithZone, Activity.new('start_time' => 'Thu, 1 Sep 2011 17:41:28').start_time
  end
end
