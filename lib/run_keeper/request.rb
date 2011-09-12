module RunKeeper
  class Request
    HEADERS = {
      'fitness_activities' => 'application/vnd.com.runkeeper.FitnessActivityFeed+json',
      'profile'            => 'application/vnd.com.runkeeper.Profile+json',
      'user'               => 'application/vnd.com.runkeeper.User+json'
    }

    def initialize client_id, client_secret, token
      @client_id, @client_secret, @token = client_id, client_secret, token
    end

    def fitness_activities options = {}
      ActivityRequest.new(self, options).get_activities
    end

    def profile
      Profile.new request('profile').parsed.merge(:userid => @user.userid)
    end

    def request endpoint, params = {}
      response = access_token.get(user.send(endpoint), :headers => {'Accept' => HEADERS[endpoint]}, :parse => :json) do |request|
        request.params = params
      end
      parse_response response
    end

    def user
      @user ||= begin
        response = access_token.get('/user', :headers => {'Accept' => HEADERS['user']}, :parse => :json)
        User.new parse_response(response).parsed
      end
    end

  private
    def access_token
      client = OAuth2::Client.new @client_id, @client_secret, :site => 'https://api.runkeeper.com', :authorize_url => '/apps/authorize', :token_url => '/apps/token', :raise_errors => false
      OAuth2::AccessToken.new client, @token
    end

    def parse_response response
      if [200, 304].include? response.status
        response
      else
        raise Error.new(response)
      end
    end
  end
end
