module RunKeeper
  class Base
    HEADERS = {
      'fitness_activities' => 'application/vnd.com.runkeeper.FitnessActivityFeed+json',
      'profile'            => 'application/vnd.com.runkeeper.Profile+json',
      'user'               => 'application/vnd.com.runkeeper.User+json'
    }

    attr_reader :token

    def initialize client_id, client_secret, token
      @client_id, @client_secret, @token = client_id, client_secret, token
      user
    end

    def request endpoint
      response = access_token.get user.send(endpoint), :headers => {'Accept' => HEADERS[endpoint]}, :parse => :json
    end

    def fitness_activities
      response = request 'fitness_activities'
      response.parsed['items'].inject([]) do |activities, activity|
        activities << RunKeeper::Activity.new(activity)
      end
    end

    def profile
      response = request 'profile'
      RunKeeper::Profile.new response.parsed.merge(:userid => user.userid)
    end

    def user
      @user ||= begin
        response = access_token.get '/user', :headers => {'Accept' => HEADERS['user']}, :parse => :json
        User.new response.parsed
      end
    end

  private
    def access_token
      OAuth2::AccessToken.new client, token
    end

    def client
      OAuth2::Client.new @client_id, @client_secret, :site => 'https://api.runkeeper.com', :authorize_url => '/apps/authorize', :token_url => '/apps/token', :raise_errors => false
    end
  end
end
