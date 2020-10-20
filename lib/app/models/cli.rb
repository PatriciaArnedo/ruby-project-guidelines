require "tty-prompt"
require "pry"
require "artii"


class Cli 
    @@prompt = TTY::Prompt.new
    @@artii = Artii::Base.new :font => 'slant'
    @@user = nil

    def title_screen
        system('clear')
        puts @@artii.asciify("Trick-or-Treat!")
        self.auth_sequence
    end

    def auth_sequence
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


    def gameboard

    end

end