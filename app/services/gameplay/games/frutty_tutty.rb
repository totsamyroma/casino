module Gameplay
  module Games
    class FruttyTutty < Slot
      SLOTS = %w[🍒 🍋 🍊 🍉].freeze
      REWARDS = { "🍒" => 10, "🍋" => 20, "🍊" => 30, "🍉" => 40 }.freeze

      FREE_SCORES = 10
      PENALTY = 1

      CHANCE_60 = [true, true, false].freeze # to be precise, it's 2/3 chance, aka 67%
      CHANCE_30 = [true, false, false].freeze # to be precise, it's 1/3 chance, aka 33%

      def initialize(session)
        super
      end

      private

      def add_free_scores
        session.update score: session.score + FREE_SCORES
      end

      def slots
        SLOTS
      end

      def rewards
        REWARDS
      end

      def penalty
        PENALTY
      end

      def crank_lever
        roll

        reroll if reroll?

        update_session_score
      end

      def reroll
        Rails.logger.info("Bad luck, rerolling...")

        roll
      end

      def reroll?
        return false unless winning_roll?

        return CHANCE_60.sample if session.score > 60
        return CHANCE_30.sample if session.score > 40

        false
      end
    end
  end
end
