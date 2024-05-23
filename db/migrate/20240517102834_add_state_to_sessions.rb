# frozen_string_literal: true

class AddStateToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :state, :string, null: false, default: 'new_game'
  end
end
