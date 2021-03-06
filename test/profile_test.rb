require 'helper'

class ProfileTest < MiniTest::Unit::TestCase
  def test_initailization_sets_username_if_profile
    profile = Profile.new('profile' => 'http://www.runkeeper.com/user/JohnDoe')
    assert_includes profile.instance_variables, :@username
    assert_equal 'JohnDoe', profile.username
  end

  def test_initailization_sets_username_to_nil_if_no_profile
    assert_nil Profile.new.username
  end

  def test_birthday_is_UTC
    assert Profile.new('birthday' => 'Sat, Jan 1 2011 00:00:00').birthday.utc?
  end

  def test_birthday_is_nil_if_not_provided
    assert_nil Profile.new.birthday
  end
end
