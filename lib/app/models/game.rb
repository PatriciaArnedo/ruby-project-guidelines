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
        saved_games = self.where(user_id: user.id)
        # binding.pry
        if saved_games == []
            puts "\nIt appears you don't have any saved games to continue."
            sleep(1.5)
            CLI.game_menu
        else
            saved_games
        end
    end
end #Game Class

