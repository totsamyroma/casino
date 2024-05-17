module Gameplay
  module Errors
    class InactiveSession < StandardError
      def initialize(msg="You can't play on an inactive session. Start game to play.")
        super
      end
    end
  end
end
