module RunKeeper
  class User
    attr_accessor :userid, :profile, :settings, :fitness_activities, :background_activities, :sleep, :nutrition, :weight, :general_measurements, :diabetes, :records, :team

    def initialize attributes = {}
      attributes.each do |attribute, value|
        send :"#{attribute}=", value
      end
    end

    def username
      profile.split('/').last
    end
  end
end
