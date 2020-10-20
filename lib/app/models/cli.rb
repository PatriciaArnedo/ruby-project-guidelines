require "tty-prompt"
require "pry"
require "tty-cursor"
require "tty-font"


class CLI 
    @@prompt = TTY::Prompt.new
    @@user = nil
    @@table = TTY::Table.new([["🏚  1", "🏠  2", "🏠  3", "🏚  4"], 
                              ["🏠  5", "🏠  6", "🏠  7", "🏠 8"], 
                              ["🏠  9", "🏠  10", "🏠  11", "🏠 12"], 
                              ["🏠  13", "🏚  14", "🏠  15", "🏠 16"]])
    @@pastel = Pastel.new
    @@font = TTY::Font.new(:doom)

    def self.title_screen
        system('clear')
        #prints title screen
        puts @@pastel.red(@@font.write("Trick or Treat !", letter_spacing: 1))
        self.auth_sequence
    end

    def self.auth_sequence
        sleep(1.25)
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

        binding.pry

    end


    def gameboard
        #generates game board with separators
        render = @@table.render(:ascii, padding: [1,2,1,2]) do |renderer| 
            renderer.border.separator = :each_row
        end
        #prints game board
        puts render
    end


end