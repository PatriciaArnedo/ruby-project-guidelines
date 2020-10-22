class UserLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :user_location, :string
  end
end
