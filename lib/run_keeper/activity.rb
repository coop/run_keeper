module RunKeeper
  class Activity
    attr_accessor :type, :total_distance, :duration, :uri
    attr_reader :start_time

    def initialize attributes = {}
      attributes.each do |attribute, value|
        send :"#{attribute}=", value
      end
    end

    def id
      uri.split('/').last.to_i
    end

    def start_time= value
      @start_time = Time.zone.parse value
    end
  end
end
