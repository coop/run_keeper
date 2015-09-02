module RunKeeper
  class ActivityRequest
    def initialize runkeeper, options
      @runkeeper, @options = runkeeper, parse_options(options)
    end

    def get_activities
      @options[:limit] ? limit_results(request) : request
    end

  private
    def limit_results activities
      activities[0..@options[:limit] - 1]
    end

    def request activities = nil
      response   = @runkeeper.request('fitness_activities', @options[:params])
      activities = response.parsed['items'] ? response.parsed['items'].map { |activity| Activity.new(activity) } : []

      if @options[:start]
        activities -= activities.reject { |activity| (activity.start_time > @options[:start]) && (activity.start_time < @options[:finish]) }
      end

      if response.parsed['next'] && (@options[:limit].nil? || activities.size < @options[:limit])
        next_page = response.parsed['next'].scan(/page=(\d+)/)[0][0]
        @options[:params].update(:page => next_page)
        activities + request(activities)
      else
        activities
      end
    end

    def parse_options options
      options[:params] = {}
      options[:start]  = Time.utc(*options[:start].split('-')) if options[:start]
      options[:finish] = options[:start] && options[:finish] ? Time.utc(*options[:finish].split('-'), 23, 59, 59) : Time.now.utc
      options
    end
  end
end
