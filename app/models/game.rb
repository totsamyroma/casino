# frozen_string_literal: true

class Game < ApplicationRecord
  enum kind: { slots: 0 }

  has_many :sessions
  has_many :players, through: :sessions

  validates :name, presence: true, uniqueness: true
  validates :credits, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
