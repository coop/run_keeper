module RunKeeper
  class Base
    HEADERS = {
      'fitness_activities' => 'application/vnd.com.runkeeper.FitnessActivityFeed+json',
      'profile'            => 'application/vnd.com.runkeeper.Profile+json',
      'user'               => 'application/vnd.com.runkeeper.User+json'
    }

    def initialize client_id, client_secret
      @client_id, @client_secret = client_id, client_secret
    end

    def fitness_activities token, options = {}
      start, finish = options[:start], options[:finish].presence || Time.zone.now if options[:start].present?
      limit         = options[:limit].presence || 25

      response = request token, 'fitness_activities'
      response.parsed['items'].inject([]) do |activities, activity|
        activities << Activity.new(activity)
      end
    end

    def profile token
      response = request token, 'profile'
      RunKeeper::Profile.new response.parsed.merge(:userid => user.userid)
    end

    def user token
      @user ||= begin
        response = access_token(token).get '/user', :headers => {'Accept' => HEADERS['user']}, :parse => :json
        User.new response.parsed
      end
    end

  private
    def access_token token
      OAuth2::AccessToken.new client, token
    end

    def client
      OAuth2::Client.new @client_id, @client_secret, :site => 'https://api.runkeeper.com', :authorize_url => '/apps/authorize', :token_url => '/apps/token', :raise_errors => false
    end

    def request token, endpoint
      response = access_token(token).get user(token).send(endpoint), :headers => {'Accept' => HEADERS[endpoint]}, :parse => :json
    end
  end
end
