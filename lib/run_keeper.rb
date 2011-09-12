require "date"
require "oauth2"
require "run_keeper/base"
require "run_keeper/activity"
require "run_keeper/activity_request"
require "run_keeper/profile"
require "run_keeper/request"
require "run_keeper/user"
require "run_keeper/version"

module RunKeeper
  def self.new client_id, client_secret, token = nil
    Request.new client_id, client_secret, token
  end

  class Error < OAuth2::Error; end
end
