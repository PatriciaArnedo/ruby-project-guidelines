class User < ActiveRecord::Base

    has_many :games
    has_many :candies, through: :games
    
end