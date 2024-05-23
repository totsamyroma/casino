# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :nick, null: false, index: { unique: true }, limit: 30
      t.decimal :credits, null: false, default: 0, precision: 10, scale: 2

      t.timestamps
    end

    add_reference :sessions, :player, null: false, foreign_key: true
  end
end
