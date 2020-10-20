class AdjustCandyColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :candies, :game_id, :integer
    remove_column :candies, :found, :boolean
  end
end
