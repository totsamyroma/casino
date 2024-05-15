class Game < ApplicationRecord
  CREDITS = {
    frutty_tutty: 10
  }.freeze

  enum kind: { slots: 0 }

  has_many :sessions, inverse_of: :game
end
