class GameComplete < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :game_complete, :boolean
  end
end
