class AdjustGameColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :bully_location, :string
    add_column :games, :bag, :string
  end
end
