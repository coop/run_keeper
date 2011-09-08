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
      limit = options[:limit] || 25
      if !options[:start].nil?
        start  = Time.utc *options[:start].split('-')
        finish = options[:finish].nil?? Time.now.utc : Time.utc(*options[:finish].split('-'))
      end

      request(token, 'fitness_activities').parsed['items'].inject([]) do |activities, activity|
        activity = Activity.new activity
        if !options[:start].nil?
          if activity.start_time >= start && activity.start_time <= finish
            activities << activity unless activities.size >= limit
          end
        else
          activities << activity unless activities.size >= limit
        end
        activities
      end
    end

    def profile token
      Profile.new request(token, 'profile').parsed.merge(:userid => @user.userid)
    end

    def request token, endpoint
      parse_response access_token(token).get(user(token).send(endpoint), :headers => {'Accept' => HEADERS[endpoint]}, :parse => :json)
    end

    def user token
      @user ||= User.new access_token(token).get('/user', :headers => {'Accept' => HEADERS['user']}, :parse => :json).parsed
    end

  private
    def access_token token
      client = OAuth2::Client.new @client_id, @client_secret, :site => 'https://api.runkeeper.com', :authorize_url => '/apps/authorize', :token_url => '/apps/token', :raise_errors => false
      OAuth2::AccessToken.new client, token
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
