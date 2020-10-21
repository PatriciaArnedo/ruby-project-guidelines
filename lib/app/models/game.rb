class Game < ActiveRecord::Base

    belongs_to :user
    has_many :candies

    serialize :bag
    serialize :bully_location

    @@prompt = TTY::Prompt.new

    # def save
    #     Game.create(name, user_id, bag, turn_count, bully_location)
    # end

    def self.load(user)
        self.where(user_id: user.id)
    end
end #Game Class

