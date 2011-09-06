module RunKeeper
  class User
    attr_accessor :userID, :profile, :settings, :fitness_activities, :background_activities, :sleep, :nutrition, :weight, :general_measurements, :diabetes, :records, :team, :strength_training_activities

    def initialize attributes = {}
      attributes.each do |attribute, value|
        send :"#{attribute}=", value
      end
    end
    alias :userid :userID
  end
end
