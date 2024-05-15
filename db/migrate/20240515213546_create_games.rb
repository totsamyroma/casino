class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.integer :kind, null: false

      t.timestamps
    end
  end
end
