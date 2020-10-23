class AddHighScoreColToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :high_scores, :integer
  end
end
