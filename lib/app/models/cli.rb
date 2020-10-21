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
    @@bully = @@table[@bx = 0,@by = 0]

    def self.title_screen
        system('clear')
        #prints title screen
        puts @@pastel.red(@@font.write("Trick or Treat !", letter_spacing: 1))
        #self.auth_sequence
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

        # binding.pry

    end


    #PLAYER MOVEMENT LOGIC METHODS:

    def self.generate_player
        #generates player at a random location on the board. 
        @@player = @@table[@x = rand(1..4),@y = rand(1..4)]
    end

    def self.print_player_loc
        puts "You are at #{@@player}."
        @@player
    end
    
    @@player = self.generate_player
        
    
    def self.move_up
        #checks that location is not out of bounds 
        if @x - 1 < 1 
            new_loc = @@player
        else
            new_loc = @@table[@x= @x-1, @y]
        end
        
        #prints this if new location was out of bounds 
        if new_loc == @@player
            @@player = @@player
            puts "You cannot go there."
            puts "You are at #{@@player}."
        else
            #changes player location to new location
            @@player = new_loc
            puts "You moved up, you are now at #{@@player}."
        end
        @@player
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
            puts "You moved down, you are now at #{@@player}."
        end
        @@player
    end
    
    def self.move_left
        #checks that location is not out of bounds 
        if @y - 1 < 1 
            new_loc = @@player
        else
            new_loc = @@table[@x, @y=@y - 1]
        end
        
        #prints this if new location was out of bounds 
        if new_loc == @@player
            @@player = @@player
            puts "You cannot go there."
            puts "You are at #{@@player}."
        else
            #changes player location to new location
            @@player = new_loc
            puts "You moved left, you are now at #{@@player}."
        end
        @@player
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
        @@player    
    end
    
    
    def self.prompt_user_movement
        sleep(1)
        prompt = TTY::Prompt.new
        
        #repeats prompts for ten turns
        turns = 0
        while turns <= 10 do
            selection = prompt.select("Choose a direction:") do |option|
                option.choice "Up"
                option.choice "Down"
                option.choice "Left"
                option.choice "Right"
            end
            
            #calls movement methods for each selection
            if selection == "Up"
                system('clear')
                self.title_screen
                self.move_up
                self.gameboard
            elsif selection == "Down"
                system('clear')
                self.title_screen
                self.move_down
                self.gameboard
            elsif selection == "Left"
                system('clear')
                self.title_screen
                self.move_left
                self.gameboard
            elsif selection == "Right"
                system('clear')
                self.title_screen
                self.move_right
                self.gameboard
            end
            #increments turns
            turns +=1
        end
    end

    def self.gameboard
        #generates game board with separators
        render = @@table.render(:ascii, padding: [1,2,1,2]) do |renderer| 
            renderer.border.separator = :each_row
            renderer.filter = ->(val, row_index, col_index) do
                if row_index == @x and col_index == @y
                    val = "   👻"
                else
                    val
                end
            end
            
        end

        #prints game board
        puts render
        self.print_player_loc
    end

    
    def self.generate_bully
        #generates bully at a random location on the board. 
        @@bully = @@table[@bx = rand(1..4), @by = rand(1..4)]
        
        puts "Be careful! The bully is at #{@@bully}!"
    end

end #CLI class


