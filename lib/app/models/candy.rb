class Candy < ActiveRecord::Base

belongs_to :game


def self.tally_points
    #this method needs to iterate though every game and access their candy bags, then
    #iterate through each bag and tally all the points, save each point total with the name of the user
    #put them all in order and then print them to the screen.
end




end