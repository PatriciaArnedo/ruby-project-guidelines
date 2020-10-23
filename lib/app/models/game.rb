require "tty-prompt"

class Game < ActiveRecord::Base

    belongs_to :user
    has_many :candies

    serialize :bag
    serialize :bully_location
    serialize :user_location
    serialize :shuffled_candy
    serialize :visited?

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
        # puts "Please enter a name to save your game as:"
        # name = gets.chomp
        # current_game.name = name
        # binding.pry
        Game.create(name: name, user_id: current_game.user_id, 
            turn_count: CLI.turns, 
            bully_location: CLI.bully_reference, 
            bag: current_game.bag, game_complete: false,
            visited_coordinates: CLI.visited,
            shuffled_candy: Candy.shuffled_candy,
            user_location: CLI.player_reference,
            high_scores: Candy.sum_candies
            )
        # puts "Congratulations, your game has been saved as '#{current_game.name}.'"
        # sleep(2)
        # puts "You will now return to the main menu."
        # sleep(2)
        # CLI.title_screen
    end

    def self.display_highscores
        # binding.pry
        max_scores = self.all.max_by(10){|game| game.high_scores}

        user_ids = max_scores.map{|game| game.user_id}

        players = user_ids.map {|id| User.find(id).name}
        scores= max_scores.map{|game| game.high_scores}
        # binding.pry
        puts "\n\nHIGH SCORES!!!!\n"
        i = 0
        while i < 11
            puts "#{i + 1}. #{players[i]} - #{scores[i]}"
            i+=1
        end

        prompt = Prompt.new
        # scores.each{|score| puts score}
        # userids = max_scores.map{|game| game.user_id} 

        # users = userids.each do |uid|
        #     User.all.where(User.id == uid)
        # end

        # names = users.map{|user| user.name}

        # names.each{|name| puts name}

    end

    def complete_game_sequence
        self.game_complete = true
    end

    # def self.high_scores
    #     completed_games = self.where(game_complete: true) #this works
        
        
        
    #     sorted_games = completed_games.sort_by {|game| game.score}
    # end

    # def tally_scores
    #     com
    # end
    


end #Game Class

