require 'helper'

class ActivityTest < MiniTest::Unit::TestCase
  def test_id_is_nil_when_no_uri
    assert_nil Activity.new.id
  end

  def test_id_returns_an_integer_from_uri
    assert_instance_of Fixnum, Activity.new('uri' => '/profile/12345').id
  end

  def test_id_returns_id_from_uri
    assert_equal 12345, Activity.new('uri' => '/profile/12345').id
  end

  def test_start_time_is_UTC
    assert Activity.new('start_time' => 'Thu, 1 Sep 2011 17:41:28').start_time.utc?
  end
end
