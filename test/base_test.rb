require 'helper'

class BaseTest < MiniTest::Unit::TestCase
  def test_initialization_sets_client_id_and_client_secret
    runkeeper = RunKeeper::Base.new('client_id', 'client_secret')
    assert_includes runkeeper.instance_variables, :@client_id
    assert_includes runkeeper.instance_variables, :@client_secret
  end

  def test_fitness_activities_with_a_valid_token_returns_an_array
    stub_successful_runkeeper_fitness_activities_request
    assert_instance_of Array, Base.new('client_id', 'client_secret').fitness_activities('valid_token')
  end

  def test_fitness_activities_with_a_valid_token_returns_runkeeper_activities
    stub_successful_runkeeper_fitness_activities_request
    Base.new('client_id', 'client_secret').fitness_activities('valid_token').collect(&:class).each do |klass|
      assert_equal RunKeeper::Activity, klass
    end
  end
end
