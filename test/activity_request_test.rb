require 'helper'

class ActivityRequestTest < MiniTest::Unit::TestCase
  def test_limit_request_returns_subset_of_results
    assert_equal 1, ActivityRequest.new(Object.new, :limit => 1).send(:limit_results, [1, 2, 3]).size
  end

  def test_parse_options_has_default_keys
    assert_equal [:params, :finish].sort, ActivityRequest.new(Object.new, {}).send(:parse_options, {}).keys.sort
  end

  def test_parse_options_includes_limit
    assert_equal [:limit, :params, :finish].sort, ActivityRequest.new(Object.new, {:limit => 1}).send(:parse_options, {:limit => 1}).keys.sort
  end

  def test_parse_options_includes_start
    assert_equal [:params, :start, :finish].sort, ActivityRequest.new(Object.new, {:start => '2011-01-01'}).send(:parse_options, {:start => '2011-01-01'}).keys.sort
  end
end
