# RunKeeper Client API

## Installation

RunKeeper is available from rubygems.org.

``` sh
$ gem install run_keeper
```

## Usage

``` ruby
require 'run_keeper'

runkeeper = RunKeeper.new 'client_id', 'client_secret'
runkeeper.authorize_url 'http://your.com/callback/url'
# => 'https://runkeeper.com/apps/authorize?response_type=code&client_id=client_id&redirect_uri=http%3A%2F%2Fyour.com%2Fcallback%2Furl'

runkeeper.token = runkeeper.get_token 'authorization_code_value', 'http://your.com/callback/url'

# return the users profile
runkeeper.profile
# => RunKeeper::Profile
```

### Fitness Activities

Fitness Activities (http://developer.runkeeper.com/healthgraph/fitness-activities) are a list of past activities completed by a user. Calling `fitness_activities` without any options will get all activities since the user signed up to RunKeeper.

``` ruby
runkeeper.fitness_activities
# => [RunKeeper::Activity, ...]
```

Fitness Activities takes a series of arguments in the form of an options hash. Supported arguments: `start`, `finish` and `limit`:

``` ruby
# Get all activities starting from the 1st Jan, 2011
runkeeper.fitness_activities(:start => '2011-01-01')

# Get all activities between 1st Jan, 2011 and 1st Feb, 2011
runkeeper.fitness_activities(:start => '2011-01-01', :finish => '2011-02-01')

# Get the last 10 activities
runkeeper.fitness_activities(:limit => 10)
```

## Dates

RunKeeper doesn't store users time zones, they rely on the device sending the information for the correct time. Because of this I have decided to format all dates as UTC.

## Using RunKeeper mock requests in your App

While developing RunKeeper a few mocked responses were used and have been made available for your test suite.

``` ruby
# helper.rb
require 'run_keeper/mock_requests'
include MockRequests
```

## Errors

All errors are a wrapper around the `OAuth2::Error` class. Errors will be raised on all requests that do not return a 200 or 304 response code.

## Final Notes

Do not be afraid to open up the source code and peek inside. The library is built on top of the wonderful [OAuth2](https://github.com/intridea/oauth2/) gem and should be fairly easy to debug.

## Contributing

Patches welcome!

1. Fork the repository
2. Create a topic branch
3. Write tests and make changes
4. Make sure the tests pass by running `rake`
5. Push and send a pull request on GitHub

## Copyright

Copyright © 2011 Tim Cooper. RunKeeper is released under the MIT license. See LICENSE for details.
