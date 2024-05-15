class Session < ApplicationRecord
  belongs_to :game, inverse_of: :sessions
end
