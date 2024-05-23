module Gameplay
  module Errors
    class FinishedSession < StandardError
      ERROR_MESSAGE = "You can't play on a finished session. Start a new game."

      def initialize(msg = ERROR_MESSAGE)
        super
      end
    end
  end
end
