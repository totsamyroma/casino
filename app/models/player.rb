class Player < ApplicationRecord
  has_many :sessions
  has_many :games, through: :sessions

  validates :nick, presence: true, uniqueness: true
  validates :credits, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
