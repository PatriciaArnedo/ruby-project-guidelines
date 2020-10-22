class Candy < ActiveRecord::Base

    belongs_to :game

    @@shuffled_candy = []

    def self.tally_points
        #this method needs to iterate though every game and access their candy bags, then
        #iterate through each bag and tally all the points, save each point total with the name of the user
        #put them all in order and then print them to the screen.
    end

    def bag_my_candy(candy)
        CLI.current_game.bag << @@shuffled_candy.pop
    end

    def self.game_candy 
        all_candy = Candy.all
        @@shuffled_candy = all_candy.shuffle
    end

    def self.shuffled_candy
        @@shuffled_candy
    end

end