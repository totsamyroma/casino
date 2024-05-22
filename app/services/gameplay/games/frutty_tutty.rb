module Gameplay
  module Games
    class FruttyTutty < Slot
      SLOTS = %w[🍒 🍋 🍊 🍉].freeze
      SLOTS_NUMBER = 3
      REWARDS = { "🍒" => 10, "🍋" => 20, "🍊" => 30, "🍉" => 40 }.freeze

      PENALTY = 1

      CHANCE_60 = [true, true, false].freeze # to be precise, it's 2/3 chance, aka 67%
      CHANCE_30 = [true, false, false].freeze # to be precise, it's 1/3 chance, aka 33%

      def initialize(session)
        super
      end

      def start!
        super

        add_free_scores
      end

      private

      def add_free_scores
        session.update score: session.score + session.game.credits
      end

      def slots
        SLOTS
      end

      def slots_number
        SLOTS_NUMBER
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

        return reroll_with_chance_60? if session.score > 60
        return reroll_with_chance_30? if session.score > 40

        false
      end

      def reroll_with_chance_60?
        CHANCE_60.sample
      end

      def reroll_with_chance_30?
        CHANCE_30.sample
      end
    end
  end
end
