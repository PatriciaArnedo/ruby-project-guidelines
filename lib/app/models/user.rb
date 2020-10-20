require 'tty-prompt'
require_relative 'cli.rb'
require 'tty-cursor'

class User < ActiveRecord::Base
    has_many :games
    has_many :candies, through: :games
    @@prompt = TTY::Prompt.new

    def self.login
        username = @@prompt.ask("Please enter your name:")
        if self.find_by(name: username)
            self.find_by(name: username).password_check   #this is pseudocode because username is a string not an object
        else
            puts "That user does not exist."
            sleep(1)
            
            CLI.auth_sequence
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
            CLI.game_menu #another fake method just to hash out how the flow will work
        else
            self.create(name: username, password: password)
        end
    end

    def self.delete_user
        ##The method needs to be: 1) ask which user to delete, 2)check to see if that user exits,
        ##3) if the user doesnt exist, return them to the menu, 4)if the user does exist, ask for the
        ##password, 5) check the password exists, 6)if password matches destroy the user. Need to figure
        ##out where to find the user id so i can use it to destroy the entry in the table.
        @username = @@prompt.ask("Which user would you like to delete?")
        if self.find_by(name: @username)
            password = @@prompt.mask("Please enter this user's password:")
            User.destroy() if User.find_by(name: username, password: password)
        else
            puts "That username is invalid."
        end
    end

    def password_check
        password = @@prompt.mask("Please enter your password:")
        if self.password == password
            self
        else
            puts "That password was incorrect"
        end
    end


    
end #User Class