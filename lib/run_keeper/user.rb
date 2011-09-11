module RunKeeper
  class User < Base
    attr_accessor :profile, :settings, :fitness_activities, :background_activities, :sleep, :nutrition, :weight, :general_measurements, :diabetes, :records, :team, :strength_training_activities
    attr_reader :userid

    def initialize attributes = {}
      super attributes
      self.userid = attributes['userID'] if attributes['userID']
    end

    def userid= value
      @userid = value
    end
  end
end
