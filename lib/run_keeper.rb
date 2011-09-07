require 'active_support/time'
require "oauth2"
require "run_keeper/activity"
require "run_keeper/base"
require "run_keeper/profile"
require "run_keeper/user"
require "run_keeper/version"

module RunKeeper
  Time.zone = 'UTC'

  def self.new client_id, client_secret
    Base.new client_id, client_secret
  end
end
