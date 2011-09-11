module RunKeeper
  class Activity < Base
    attr_accessor :type, :total_distance, :duration, :uri
    attr_reader :start_time

    def id
      uri.split('/').last.to_i if uri
    end

    def start_time= value
      datetime    = DateTime.parse value
      @start_time = Time.utc datetime.year, datetime.month, datetime.day, datetime.hour, datetime.min, datetime.sec
    end
  end
end
