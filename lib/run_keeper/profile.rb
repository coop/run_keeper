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
      @birthday = Time.zone.parse value
    end

    def username= profile
      @username = profile.split('/').last if profile
    end
  end
end
