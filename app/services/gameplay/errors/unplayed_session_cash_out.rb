# frozen_string_literal: true

module Gameplay
  module Errors
    class UnplayedSessionCashOut < StandardError
      ERROR_MESSAGE = "You can't cash out credits on unplayed session. Make at least one roll."

      def initialize(msg = ERROR_MESSAGE)
        super
      end
    end
  end
end
