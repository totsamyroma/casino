module Gameplay
  module Errors
    class FinishedSessionError < StandardError
      def initialize(msg="Can't play on a finished session")
        super
      end
    end
  end
end
