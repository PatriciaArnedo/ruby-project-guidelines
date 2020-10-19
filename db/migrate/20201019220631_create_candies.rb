class CreateCandies < ActiveRecord::Migration[6.0]
  def change
    create_table :candies do |t|
      t.string :name
      t.integer :candy_value
      t.integer :game_id
      t.boolean :found
    end
  end
end
