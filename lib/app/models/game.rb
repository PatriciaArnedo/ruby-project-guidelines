class Game < ActiveRecord::Base

    belongs_to :user
    has_many :candies

    serialize :bag
    serialize :bully_location
    serialize :user_location

    @@prompt = TTY::Prompt.new



    def self.load(user)
        saved_games = self.where(user_id: user.id)
        # binding.pry
        if saved_games == []
            puts "\nIt appears you don't have any saved games to continue."
            sleep(2)
            CLI.game_menu
        else
            saved_games
        end
    end

    def self.save_game(current_game)
        puts "Please enter a name to save your game as:"
        name = gets.chomp
        current_game.name = name
        # binding.pry
        Game.create(name: name, user_id: current_game.user_id, 
            turn_count: current_game.turn_count, 
            bully_location: current_game.bully_location, 
            bag: current_game.bag, game_complete: false
            )
        puts "Congratulations, your game has been saved as '#{current_game.name}.'"
        sleep(2)
        puts "You will now return to the main menu."
        sleep(2)
        CLI.title_screen
    end

    def complete_game
        self.game_complete = true
    end

    def self.high_scores
        completed_games = self.where(game_complete: true) #this works
        
        
        
        sorted_games = completed_games.sort_by {|game| game.score}
    end

    def tally_scores
        com
    end
    


end #Game Class

