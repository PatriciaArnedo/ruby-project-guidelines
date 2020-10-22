require 'pry'


# candies = [
   # {name: "Raisins", candy_value: 2},
   # {name: "Circus Peanuts", candy_value: 3},
   # {name: "Candy Corn", candy_value: 4},
   # {name: "Pennies", candy_value: 0},
   # {name: "Cough Drops", candy_value: 1},
   # {name: "Tootsie Pops", candy_value: 5},
   # {name: "Fun-size M&M's", candy_value: 5},
   # {name: "Bag of Doritos", candy_value: 6},
   # {name: "Handful of Mini Candybars", candy_value: 9},
   # {name: "Unattended Bowl of Candy", candy_value: 10},
   # {name: "Gummi Worms", candy_value: 5},
   # {name: "Banana", candy_value: 3},
   # {name: "Sour-Patch Kids", candy_value: 7},
   # {name: "Candy Dots", candy_value: 4},
   # {name: "Full-size Reeces", candy_value: 8}  
# ]
# Candy.create(candies)

more_candies = [
   {name: "Bazooka Joe Bubble Gum", candy_value: 4},
   {name: "Kit Kat Bar", candy_value: 6},
   {name: "Crayon", candy_value: 1},
   {name: "Reeces Pieces", candy_value: 6},
   {name: "Peanut Butter Crackers", candy_value: 2},
   {name: "Dum Dums", candy_value: 3},
   {name: "Giant Jaw Breaker", candy_value: 5},
   {name: "Ran out of Candy, but here's $10!", candy_value: 10},
   {name: "Ran out of Candy", candy_value: 0},
]

Candy.create(more_candies)

Game.destroy_all

test_games = [
   {user_id: 11, name: "there is a", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: true},
   {user_id: 11, name: "chance this might", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: false},
   {user_id: 11, name: "work, so here's", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: true},
   {user_id: 11, name: "hoping that this", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: false},
   {user_id: 11, name: "becomes the menu", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: true},
   {user_id: 6, name: "a", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: false},
   {user_id: 8, name: "2", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: true},
   {user_id: 8, name: "b", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: false},
   {user_id: 6, name: "c", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: true},
   {user_id: 6, name: "k", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: true},
   {user_id: 8, name: "sdf", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: false},
   {user_id: 6, name: "no", turn_count: 0, user_location: nil, bully_location: nil, bag: nil, game_complete: false}
   ]

Game.create(test_games)