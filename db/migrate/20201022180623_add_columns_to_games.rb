class AddColumnsToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :visited_coordinates, :string
    add_column :games, :shuffled_candy, :string
  end
end
