require 'tty-prompt'

class User < ActiveRecord::Base
    has_many :games
    has_many :candies, through: :games
    @@prompt = TTY::Prompt.new

    def self.login
        username = @@prompt.ask("Please enter your name:")
        password = @@prompt.mask("Please enter your password:")
        self.find_by(name: username, password: password)
    end

    def self.new_user
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
    
end