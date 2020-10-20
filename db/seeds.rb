# class CreateCandies < ActiveRecord::Migration[6.0]
#     def change
#       create_table :candies do |t|
#         t.string :name
#         t.integer :candy_value
#         t.integer :game_id
#         t.boolean :found
#       end
#     end
#   end

@@Candy = [
    Candy.new(name: "Raisins", candy_value: 2, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Circus Peanuts", candy_value: 3, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Candy Corn", candy_value: 4, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Pennies", candy_value: 0, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Cough Drops", candy_value: 1, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Tootsie Pops", candy_value: 5, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Fun-size M&M's", candy_value: 5, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Bag of Doritos", candy_value: 6, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Handful of Mini Candybars", candy_value: 9, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Unattended Bowl of Candy", candy_value: 10, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Gummi Worms", candy_value: 5, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Banana", candy_value: 3, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Sour-Patch Kids", candy_value: 7, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Candy Dots", candy_value: 4, game_id: @@game_id, found: FALSE)
    Candy.new(name: "Full-size Reeces", candy_value: 8, game_id: @@game_id, found: FALSE)  
]