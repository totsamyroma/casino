class Player < ApplicationRecord
  has_many :sessions
  has_many :games, through: :sessions
end
