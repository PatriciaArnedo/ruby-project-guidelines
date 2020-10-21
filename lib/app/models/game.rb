class Game < ActiveRecord::Base

    belongs_to :user
    has_many :candies

    serialize :bag
    serialize :bully_location

    @@prompt = TTY::Prompt.new

    def save
        Game.create(name, user, bag, turncount, bully_location)
    end

    def self.load
        #this method will require a special prompt based on a list generated
        #for the user to cycle through after login when they select "I suppose..."
        #It will be referenced under the elsif of line 63
    end

end