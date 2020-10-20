require "tty-prompt"
require "pry"
require "tty-cursor"
require "tty-font"


class Cli 
    @@prompt = TTY::Prompt.new
    @@user = nil
    @@table = TTY::Table.new([["0", "1", "2", "3", "4"],
                              ["1", "🏚  1", "🏠  2", "🏠  3", "🏚  4"], 
                              ["2", "🏠  5", "🏠  6", "🏠  7", "🏠 8"], 
                              ["3", "🏠  9", "🏠  10", "🏠  11", "🏠 12"], 
                              ["4", "🏠  13", "🏚  14", "🏠  15", "🏠 16"]])
    @@pastel = Pastel.new
    @@font = TTY::Font.new(:doom)
    @@player = @@table[0,0]
    @@bully = @@table[0,0]

    def self.title_screen
        system('clear')
        #prints title screen
        puts @@pastel.red(@@font.write("Trick or Treat !", letter_spacing: 1))
    end

    def self.auth_sequence
        sleep(1.25)
        prompt = TTY::Prompt.new

        options = {"Login" => 1, "New User" => 2, "Delete Account" => 3}

        choice = prompt.select("Choose an option from the menu below:", options)
        
        if choice == 1
            @@user = User.login
        elsif choice == 2
            @@user = User.new_user
        elsif choice == 3
            User.delete_user
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

    def self.generate_bully
        #generates bully at a random location on the board. 
        @@bully = @@table[@bx = rand(1..4), @by = rand(1..4)]
        
        puts "Be careful! The bully is at #{@@bully}!"
    end

    def self.move_up
        #generates new player location up one row
        new_loc = @@table[@x - 1, @y]
        
        #checks that location is not out of bounds 
        if new_loc == "1" || new_loc == "2" || new_loc == "3" || new_loc == "4" 
            puts "You cannot go there."
            puts "You are at #{@@player}."
        else
            @@player = new_loc
            puts "You moved up, you are now at #{@@player}."
        end
    end

    def self.move_down
        #generates new player location down one row
        new_loc = @@table[@x + 1, @y]
        
        #checks that location is not out of bounds 
        if new_loc == nil 
            puts "You cannot go there."
            puts "You are at #{@@player}."
        else
            @@player = new_loc
            puts "You moved down, you are now at #{@@player}."
        end
    end




end