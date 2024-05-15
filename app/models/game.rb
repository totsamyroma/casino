class Game < ApplicationRecord
  CREDITS = {
    frutty_tutty: 10
  }.freeze

  enum kind: { slots: 0 }
end
