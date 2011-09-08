module RunKeeper
  class Profile
    attr_accessor :name, :location, :athlete_type, :goal, :gender, :birthday, :elite, :profile, :small_picture, :normal_picture, :medium_picture, :large_picture, :userid
    attr_reader :username

    def initialize attributes = {}
      attributes.each do |attribute, value|
        send :"#{attribute}=", value if respond_to? :"#{attribute}="
      end
      self.username = profile
    end

    def birthday= value
      datetime  = DateTime.parse value
      @birthday = Time.utc datetime.year, datetime.month, datetime.day, datetime.hour, datetime.min, datetime.sec
    end

    def username= profile
      @username = profile.split('/').last if profile
    end
  end
end
