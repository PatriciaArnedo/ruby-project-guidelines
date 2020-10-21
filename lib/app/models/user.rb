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
            self.find_by(name: username).password_check
        else
            self.user_dne
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
        username = @@prompt.ask("Which user would you like to delete?")
        if self.find_by(name: username) 
            user = self.find_by(name: username).password_check
            if user
                # binding.pry
                User.destroy(user.id)
                puts "\nCongratulations, that user has been officially ghosted!"
                sleep(2)
                CLI.title_screen
            else
                CLI.title_screen
            end
        else
            self.user_dne
        end
    end

    def password_check
        password = @@prompt.mask("Please enter your password:")
        if self.password == password
            self
        else
            puts "\nWe're sorry, but that password was incorrect."
            sleep(2)
            return nil
        end
    end

    def self.user_dne
        puts "\nWe're sorry, but that user does not exist."
        sleep(2)
        CLI.title_screen
    end


    
end #User Class

