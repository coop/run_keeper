module RunKeeper
  class Request
    HEADERS = {
      'fitness_activities' => 'application/vnd.com.runkeeper.FitnessActivityFeed+json',
      'profile'            => 'application/vnd.com.runkeeper.Profile+json',
      'user'               => 'application/vnd.com.runkeeper.User+json'
    }

    attr_writer :token

    def initialize client_id, client_secret, token
      @client_id, @client_secret, @token = client_id, client_secret, token
    end

    def authorize_url redirect_uri
      client('https://runkeeper.com').auth_code.authorize_url :redirect_uri => redirect_uri
    end

    def fitness_activities options = {}
      ActivityRequest.new(self, options).get_activities
    end

    def get_token code, redirect_uri
      @token = client('https://runkeeper.com').auth_code.get_token(code, :redirect_uri => redirect_uri).token
    rescue OAuth2::Error => e
      raise Error.new(e.response)
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
      OAuth2::AccessToken.new client, @token
    end

    def client site = 'https://api.runkeeper.com'
      OAuth2::Client.new @client_id, @client_secret, :site => site, :authorize_url => '/apps/authorize', :token_url => '/apps/token', :raise_errors => false
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
