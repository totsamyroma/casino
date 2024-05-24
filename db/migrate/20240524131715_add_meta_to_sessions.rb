# frozen_string_literal: true

class AddMetaToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :meta, :jsonb, null: false, default: {}
  end
end
