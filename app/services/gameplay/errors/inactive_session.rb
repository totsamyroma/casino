# frozen_string_literal: true

module Gameplay
  module Errors
    class InactiveSession < StandardError
      ERROR_MESSAGE = "You can't play on an inactive session. Start game to play."

      def initialize(msg = ERROR_MESSAGE)
        super
      end
    end
  end
end
