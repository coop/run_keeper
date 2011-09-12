module MockRequests
  def stub_successful_runkeeper_fitness_activities_request
    stub_successful_runkeeper_user_request
    stub_successful_runkeeper_fitness_activities_page_2_request
    stub_runkeeper_fitness_activities_request.to_return :status => 200, :body => {"size" => "4", "items" => [{"type" => "Running", "start_time" => "Thu, 25 Aug 2011 17:41:28", "total_distance" => "5492.22273600001", "duration" => "1743.946", "uri" => "/activities/39"}, {"type" => "Running", "start_time" => "Thu, 1 Sep 2011 17:41:28", "total_distance" => "5492.22273600001", "duration" => "1743.946", "uri" => "/activities/40"}, {"type" => "Running", "start_time" => "Fri, 2 Sep 2011 17:41:28", "total_distance" => "5492.22273600001", "duration" => "2090.123", "uri" => "/activities/41"}, {"type" => "Running", "start_time" => "Wed, 7 Sep 2011 17:41:28", "total_distance" => "5492.22273600001", "duration" => "1743.946", "uri" => "/activities/42"}], "next" => "/fitnessActivities?page=1"}, :headers => {"content-type" => "application/vnd.com.runkeeper.FitnessActivityFeed+json;charset=ISO-8859-1"}
  end

  def stub_successful_runkeeper_profile_request
    stub_successful_runkeeper_user_request
    stub_runkeeper_profile_request.to_return :status => 200, :body => {"name" => "John Doe", "location" => "Anytown, USA", "athlete_type" => "Runner", "goal" => "To get off the couch", "gender" => "M", "birthday" => "Sat, Jan 1 2011 00:00:00", "elite" => "true", "profile" => "http://www.runkeeper.com/user/JohnDoe", "small_picture" => "http://www.runkeeper.com/user/JohnDoe/small.jpg", "normal_picture" => "http://www.runkeeper.com/user/JohnDoe/normal.jpg", "medium_picture" => "http://www.runkeeper.com/user/JohnDoe/medium.jpg", "large_picture" => "http://www.runkeeper.com/user/JohnDoe/large.jpg"}, :headers => {"content-type" => "application/vnd.com.runkeeper.profile+json;charset=ISO-8859-1"}
  end

  def stub_successful_runkeeper_token_request
    stub_runkeeper_token_request.to_return :status => 200, :body => {'access_token' => 'my_token', 'token_type' => 'Bearer'}, :headers => {"content-type" => "application/json;charset=ISO-8859-1"}
  end

  def stub_successful_runkeeper_user_request
    stub_runkeeper_user_request.to_return :status => 200, :body => {"userID" => /\d+/, "profile" => "/profile", "settings" => "/settings", "fitness_activities" => "/fitnessActivities", "background_activities" => "/backgroundActivities", "sleep" => "/sleep", "nutrition" => "/nutrition", "weight" => "/weight", "general_measurements" => "/generalMeasurements", "diabetes" => "/diabetes", "records" => "/records", "team" => "/team", "strength_training_activities" => "/strengthTrainingActivities"}, :headers => {'content-type' => 'application/vnd.com.runkeeper.user+json;charset=ISO-8859-1'}
  end

  def stub_unsuccessful_runkeeper_profile_request
    stub_successful_runkeeper_user_request
    stub_runkeeper_profile_request.to_return :status => 500, :body => {}, :headers => {}
  end

  def stub_unsuccessful_runkeeper_token_request
    stub_runkeeper_token_request.to_return :status => 500, :body => {}, :headers => {}
  end

  def stub_unsuccessful_runkeeper_user_request
    stub_runkeeper_user_request.to_return :status => 500, :body => {}, :headers => {}
  end

private
  def stub_successful_runkeeper_fitness_activities_page_2_request
    stub_request(:get, "https://api.runkeeper.com/fitnessActivities?page=1").
      with(:headers => {'Accept' => 'application/vnd.com.runkeeper.FitnessActivityFeed+json', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization' => /Bearer \w+/, 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => {"size" => "2", "items" => [{"type" => "Running", "start_time" => "Tue, 23 Aug 2011 17:41:28", "total_distance" => "5492.22273600001", "duration" => "1743.946", "uri" => "/activities/38"}, {"type" => "Running", "start_time" => "Sun, 21 Aug 2011 17:41:28", "total_distance" => "5492.22273600001", "duration" => "1743.946", "uri" => "/activities/37"}]}, :headers => {"content-type" => "application/vnd.com.runkeeper.FitnessActivityFeed+json;charset=ISO-8859-1"})
  end

  def stub_runkeeper_fitness_activities_request
    stub_request(:get, "https://api.runkeeper.com/fitnessActivities").
      with :headers => {'Accept'=>'application/vnd.com.runkeeper.FitnessActivityFeed+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization' => /Bearer \w+/, 'User-Agent'=>'Ruby'}
  end

  def stub_runkeeper_profile_request
    stub_request(:get, "https://api.runkeeper.com/profile").
      with :headers => {'Accept'=>'application/vnd.com.runkeeper.Profile+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization' => /Bearer \w+/, 'User-Agent'=>'Ruby'}
  end

  def stub_runkeeper_token_request
    stub_request(:post, "https://runkeeper.com/apps/token").
      with :body => {"grant_type" => "authorization_code", "code" => /\w+/, "client_id" => /\w+/, "client_secret" => /\w+/, "redirect_uri" => "#{CONFIG['app_url']}/authorize/callback"},
           :headers => {'Accept' => '*/*', 'Content-Type' => 'application/x-www-form-urlencoded', 'User-Agent' => 'Ruby'}
  end

  def stub_runkeeper_user_request
    stub_request(:get, "https://api.runkeeper.com/user").
      with :headers => {'Accept'=>'application/vnd.com.runkeeper.User+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization' => /Bearer \w+/, 'User-Agent'=>'Ruby'}
  end
end
