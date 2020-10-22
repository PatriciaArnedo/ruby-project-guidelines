class Candy < ActiveRecord::Base

    belongs_to :game

    @@shuffled_candy = []

    def self.tally_points
        #this method needs to iterate though every game and access their candy bags, then
        #iterate through each bag and tally all the points, save each point total with the name of the user
        #put them all in order and then print them to the screen.
    end

    def self.bag_candy_by_id #called after #visited? comes up false
        # binding.pry
        CLI.current_game.bag << @@shuffled_candy.pop
        puts "\nYou got #{CLI.current_game.bag.last.name}!"
    end

    def self.bully_robs_you
        
        puts "The bully stole #{CLI.current_game.bag.pop.name}!"
        binding.pry

    end

    def self.sum_candies
        scores = CLI.current_game.bag.map {|candy| candy.candy_value}
        scores.reduce(:+)
    end

    def self.game_candy #called at beginning of new game
        all_candy = Candy.all
        @@shuffled_candy = all_candy.shuffle
    end

    def self.shuffled_candy
        @@shuffled_candy
    end



end #Candy class
