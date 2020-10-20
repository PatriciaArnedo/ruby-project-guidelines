class Game < ActiveRecord::Base

    belongs_to :user
    has_many :candies

    @@prompt = TTY::Prompt.new

    def initialize(user)
        @@user = user

    end



end