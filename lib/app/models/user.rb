require 'tty-prompt'

class User < ActiveRecord::Base
    has_many :games
    has_many :candies, through: :games
    @@prompt = TTY::Prompt.new

    def self.login
        ##Similar to .delete_user, 
        username = @@prompt.ask("Please enter your name:")
        if self.find_by(name: username)
            password = @@prompt.mask("Please enter your password:")
            begin_game_here if self.find_by(name: username, password: password)
            #need to create a begin_game method
        else
            puts "That user does not exist."
        end
    end

    def self.new_user
        ##This method functions as expected.
        username = @@prompt.ask("Please enter your name:")
        password = @@prompt.mask("Please enter a password:")
        confirm_password = @@prompt.mask("Please confirm your password:")
        if password != confirm_password
            puts "These passwords do not match. Please re-enter your information."
            self.new_user
        else
            self.create(name: username, password: password)
        end
    end

    def self.delete_user
        ##The method needs to be: 1) ask which user to delete, 2)check to see if that user exits,
        ##3) if the user doesnt exist, return them to the menu, 4)if the user does exist, ask for the
        ##password, 5) check the password exists, 6)if password matches destroy the user. Need to figure
        ##out where to find the user id so i can use it to destroy the entry in the table.
        username = @@prompt.ask("Which user would you like to delete?")
        if self.find_by(name: username)
            password = @@prompt.mask("Please enter this user's password:")
            User.destroy() if User.find_by(name: username, password: password)
        else
            puts "That username is invalid."

        end

    end
    
end #User Class