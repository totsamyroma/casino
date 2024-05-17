module Gameplay
  class Slot
    def initialize(session)
      @session = session
    end

    def play
      raise Errors::NotEnoughCredits if session.score.zero?
      # raise "Session is finished"  session.finished?

      crank_lever

      { sequence: sequence, reward: reward, score: session.score }
    end

    private

    attr_reader :session, :sequence, :reward

    def crank_lever
      roll

      update_session_score
    end

    def roll
      generate_sequence
      calculate_reward
      log_roll
    end

    def generate_sequence
      @sequence = Array.new(slots.size) { slots.sample }
    end

    def calculate_reward
      @reward = rewards[winning_slot] || 0
    end

    def rewards
      raise NotImplementedError
    end

    def winning_slot
      slots.find { |slot| sequence.all?(slot) }
    end

    def slots
      raise NotImplementedError
    end

    def update_session_score
      if winning_roll?
        session.update!(score: session.score + reward)
      else
        session.update!(score: session.score - penalty)
      end
    end

    def winning_roll?
      reward.positive?
    end

    def penalty
      raise NotImplementedError
    end

    def log_roll
      Rails.logger.info "Session: #{session.id} | Sequence: #{sequence} | Reward: #{reward} | Score: #{session.score}"
    end
  end
end
