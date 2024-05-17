module Gameplay
  module Errors
    class NotEnoughCredits < StandardError
      def initialize(msg="You don't have enough credits to play")
        super
      end
    end
  end
end
