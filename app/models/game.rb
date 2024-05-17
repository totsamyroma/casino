class Game < ApplicationRecord
  enum kind: { slots: 0 }

  has_many :sessions
  has_many :players, through: :sessions
end
