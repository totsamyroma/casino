module Gameplay
  module Errors
    class FinishedSession < StandardError
      def initialize(msg="You can't play on a finished session. Start a new game.")
        super
      end
    end
  end
end
