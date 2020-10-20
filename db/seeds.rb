require 'pry'


candies = [
   {name: "Raisins", candy_value: 2, game_id: @@game_id, found: FALSE}
   {name: "Circus Peanuts", candy_value: 3, game_id: @@game_id, found: FALSE}
   {name: "Candy Corn", candy_value: 4, game_id: @@game_id, found: FALSE}
   {name: "Pennies", candy_value: 0, game_id: @@game_id, found: FALSE}
   {name: "Cough Drops", candy_value: 1, game_id: @@game_id, found: FALSE}
   {name: "Tootsie Pops", candy_value: 5, game_id: @@game_id, found: FALSE}
   {name: "Fun-size M&M's", candy_value: 5, game_id: @@game_id, found: FALSE}
   {name: "Bag of Doritos", candy_value: 6, game_id: @@game_id, found: FALSE}
   {name: "Handful of Mini Candybars", candy_value: 9, game_id: @@game_id, found: FALSE}
   {name: "Unattended Bowl of Candy", candy_value: 10, game_id: @@game_id, found: FALSE}
   {name: "Gummi Worms", candy_value: 5, game_id: @@game_id, found: FALSE}
   {name: "Banana", candy_value: 3, game_id: @@game_id, found: FALSE}
   {name: "Sour-Patch Kids", candy_value: 7, game_id: @@game_id, found: FALSE}
   {name: "Candy Dots", candy_value: 4, game_id: @@game_id, found: FALSE}
   {name: "Full-size Reeces", candy_value: 8, game_id: @@game_id, found: FALSE}  
]

Candy.create(candies)