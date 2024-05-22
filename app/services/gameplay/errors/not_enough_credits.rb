module Gameplay
  module Errors
    class NotEnoughCredits < StandardError
      ERROR_MESSAGE = "You don't have enough credits to play. Start a new game."
      def initialize(msg=ERROR_MESSAGE)
        super
      end
    end
  end
end
