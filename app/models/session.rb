# frozen_string_literal: true

class Session < ApplicationRecord
  include AASM

  has_paper_trail

  belongs_to :game
  belongs_to :player

  aasm column: :state do
    state :new_game, initial: true
    state :in_progress, :won, :lost, :finished

    event :play do
      transitions from: :new_game, to: :in_progress
    end

    event :win do
      transitions from: :in_progress, to: :won
    end

    event :lose do
      transitions from: :in_progress, to: :lost
    end

    event :finish do
      transitions from: %i[new_game in_progress], to: :finished
    end
  end
end
