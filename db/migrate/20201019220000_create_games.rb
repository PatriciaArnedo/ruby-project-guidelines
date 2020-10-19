class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :user_id
      t.integer :turn_count
    end
  end
end
