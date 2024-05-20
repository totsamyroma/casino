module Gameplay
  class Slot
    def initialize(session)
      @session = session
    end

    def start!
      raise Gameplay::Errors::FinishedSession if session.finished? || session.lost? || session.won?

      session.play!
    end

    def finish!
      session.finish!
    end

    def cash_out!
      raise Gameplay::Errors::FinishedSession if session.lost?

      ApplicationRecord.transaction do
        session.finish!
        session.player.update(credits: session.player.credits + session.score)
        session.update(score: 0)
      end
    end

    def top_up!(top_up_amount)
      raise Gameplay::Errors::FinishedSession if session.finished? || session.lost? || session.won?
      # TODO
      # raise if top_up_amount is negative or not a number

      ApplicationRecord.transaction do
        session.update(score: session.score + top_up_amount)
      end
    end

    def play!
      raise Gameplay::Errors::InactiveSession if session.new_game?
      raise Gameplay::Errors::FinishedSession if session.finished? || session.lost? || session.won?
      raise Gameplay::Errors::NotEnoughCredits if session.score.zero?

      crank_lever

      { sequence: sequence, reward: reward, score: session.score }
    end

    private

    attr_reader :session, :sequence, :reward

    def crank_lever
      roll

      log_roll
      update_session
    end

    def roll
      generate_sequence
      calculate_reward
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

    def update_session
      update_session_score

      session.lose! if session.zero?
    end

    def update_session_score
      if winning_roll?
        session.update!(score: session.score + reward)
      else
        if session.score < penalty
          session.update!(score: 0)
        else
          session.update!(score: session.score - penalty)
        end
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
