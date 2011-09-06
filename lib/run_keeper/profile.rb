module RunKeeper
  class Profile
    attr_accessor :name, :location, :athlete_type, :goal, :gender, :birthday, :elite, :profile, :small_picture, :normal_picture, :medium_picture, :large_picture, :username, :userid

    def initialize attributes = {}
      attributes.each do |attribute, value|
        send :"#{attribute}=", value
      end
    end

    def birthday= value
      @birthday = Time.zone.parse value
    end
  end
end
