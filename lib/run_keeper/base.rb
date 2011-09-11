module RunKeeper
  class Base
    def initialize attributes = {}
      attributes.each do |attribute, value|
        send :"#{attribute}=", value if respond_to? :"#{attribute}="
      end
    end
  end
end
