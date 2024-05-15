class AddCreditsToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :credits, :integer, default: 0
  end
end
