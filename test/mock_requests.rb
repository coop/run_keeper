module MockRequests
  def stub_successful_runkeeper_fitness_activities_request
    stub_successful_runkeeper_user_request
    stub_runkeeper_fitness_activities_request.to_return :status => 200, :body => {"size" => "1", "items" => [{"type" => "Running", "start_time" => "Thu, 1 Sep 2011 17:41:28", "total_distance" => "5492.22273600001", "duration" => "1743.946", "uri" => "/activities/40"}], "previous" => "https://api.runkeeper.com/user/1234567890/activities?page=2"}, :headers => {"content-type" => "application/vnd.com.runkeeper.FitnessActivityFeed+json;charset=ISO-8859-1"}
  end

  def stub_successful_runkeeper_user_request
    stub_runkeeper_user_request.to_return :status => 200, :body => {"userID" => /\d+/, "profile" => "/profile", "settings" => "/settings", "fitness_activities" => "/fitnessActivities", "background_activities" => "/backgroundActivities", "sleep" => "/sleep", "nutrition" => "/nutrition", "weight" => "/weight", "general_measurements" => "/generalMeasurements", "diabetes" => "/diabetes", "records" => "/records", "team" => "/team", "strength_training_activities" => "/strengthTrainingActivities"}, :headers => {'content-type' => 'application/vnd.com.runkeeper.user+json;charset=ISO-8859-1'}
  end

private
  def stub_runkeeper_fitness_activities_request
    stub_request(:get, "https://api.runkeeper.com/fitnessActivities").
      with :headers => {'Accept'=>'application/vnd.com.runkeeper.FitnessActivityFeed+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization' => /Bearer \w+/, 'User-Agent'=>'Ruby'}
  end

  def stub_runkeeper_user_request
    stub_request(:get, "https://api.runkeeper.com/user").
      with :headers => {'Accept'=>'application/vnd.com.runkeeper.User+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization' => /Bearer \w+/, 'User-Agent'=>'Ruby'}
  end
end
