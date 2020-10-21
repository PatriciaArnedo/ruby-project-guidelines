require "tty-prompt"
require "pry"
require "tty-cursor"
require "tty-font"


class CLI 
    @@prompt = TTY::Prompt.new
    @@user = nil
    @@table = TTY::Table.new([["0", "1", "2", "3", "4"],
                              ["1", "🏚  1", "🏠  2", "🏠  3", "🏚  4"], 
                              ["2", "🏠  5", "🏠  6", "🏠  7", "🏠 8"], 
                              ["3", "🏠  9", "🏠  10", "🏠  11", "🏠 12"], 
                              ["4", "🏠  13", "🏚  14", "🏠  15", "🏠 16"]])
    @@pastel = Pastel.new
    @@font = TTY::Font.new(:doom)
    @@player = @@table[@x = 0,@y = 0]
    @@bully = @@table[@bx = 0,@by = 0]

    def self.title_screen
        system('clear')
        #prints title screen
        self.game_header
        self.auth_sequence
    end

    def self.game_header
        puts @@pastel.red(@@font.write("Trick or Treat!", letter_spacing: 1))
    end

    def self.auth_sequence
        sleep(1)
        prompt = TTY::Prompt.new

        selection = prompt.select("Choose an option from the menu below:") do |option|
            option.choice "Log In"
            option.choice "New User"
            option.choice "Delete User"
        end
        
        if selection == "Log In"
            @@user = User.login
        elsif selection == "New User"
            @@user = User.new_user
        elsif selection == "Delete User"
            User.delete_user
        end
    end

    def self.game_menu #displays the game menu for new or load after you log in or create a new user.
        sleep(1)
        system('clear')
        self.game_header
        prompt = TTY::Prompt.new

        selection = prompt.select("What would you like to do today?\n") do |option|
            option.choice "Ooh, ooh, I want to start a new game!!!\n"
            option.choice "I suppose I had better finish one I've already started"
        end
        
        if selection == "Ooh, ooh, I want to start a new game!!!\n"
            current_game = Game.new(user_id: @@user.id)
        elsif selection == "I suppose I had better finish one I've already started"
            #load screen prompt where there is a list of all saved games for current user
            #puts "It looks like you don't have any games saved." if the user has no saved game instances.
        end
    end



    def self.gameboard
        #generates game board with separators
        render = @@table.render(:ascii, padding: [1,2,1,2]) do |renderer| 
            renderer.border.separator = :each_row
        end
        #prints game board
        puts render
    end

    def self.generate_player
        #generates player at a random location on the board. 
        @@player = @@table[@x = rand(1..4),@y = rand(1..4)]
        
        
        puts "You are at #{@@player}."
    end

    
    def self.move_up
        #generates new player location up one row
        new_loc = @@table[@x=@x - 1, @y]
        
        #checks that location is not out of bounds 
        if new_loc == "1" || new_loc == "2" || new_loc == "3" || new_loc == "4" 
            @@player = @@player
            puts "You cannot go there."
            puts "You are at #{@@player}."
        else
            #changes player location to new location
            @@player = new_loc
            puts "You moved up, you are now at #{@@player}."
        end
    end
    
    def self.move_down
        #checks that location is not out of bounds 
        if @x + 1 > 4 
            new_loc = @@player
        else
            new_loc = @@table[@x= @x+1, @y]
        end
        
        #prints this if new location was out of bounds 
        if new_loc == @@player
            @@player = @@player
            puts "You cannot go there."
            puts "You are at #{@@player}."
        else
            #changes player location to new location
            @@player = new_loc
            puts "You moved right, you are now at #{@@player}."
        end
    end
    
    def self.move_left
        #generates new player location left one column
        new_loc = @@table[@x, @y=@y - 1]
        
        #checks that location is not out of bounds 
        if new_loc == "1" || new_loc == "2" || new_loc == "3" || new_loc == "4" 
            @@player = @@player
            puts "You cannot go there."
            puts "You are at #{@@player}."
        else
            #changes player location to new location
            @@player = new_loc
            puts "You moved left, you are now at #{@@player}."
        end
    end
    
    def self.move_right
        #checks that location is not out of bounds 
        if @y + 1 > 4 
            new_loc = @@player
        else
            new_loc = @@table[@x, @y=@y + 1]
        end
        
        #prints this if new location was out of bounds 
        if new_loc == @@player
            @@player = @@player
            puts "You cannot go there."
            puts "You are at #{@@player}."
        else
            #changes player location to new location
            @@player = new_loc
            puts "You moved right, you are now at #{@@player}."
        end
        
    end
    
    
    def self.prompt_user_movement
        sleep(1)
        prompt = TTY::Prompt.new
        
        #repeats prompts for ten turns
        turns = 0
        while turns <= 10 do
            selection = prompt.select("Chose a direction to move in:") do |option|
                option.choice "Up"
                option.choice "Down"
                option.choice "Left"
                option.choice "Right"
            end
            
            #calls movement methods for each selection
            if selection == "Up"
                self.move_up
            elsif selection == "Down"
                self.move_down
            elsif selection == "Left"
                self.move_left
            elsif selection == "Right"
                self.move_right
            end
            #increments turns
            turns +=1
        end
    end
    
    def self.generate_bully
        #generates bully at a random location on the board. 
        @@bully = @@table[@bx = rand(1..4), @by = rand(1..4)]
        
        puts "Be careful! The bully is at #{@@bully}!"
    end
end

