require "tty-prompt"
require "pry"
require "tty-cursor"
require "tty-font"


class CLI 
    @@prompt = TTY::Prompt.new
    @@user = nil
    @@table = TTY::Table.new([["🏠  1", "🏠  2", "🏠  3", "🏚  4", "🏠  5"], 
                              ["🏠  6", "🏠  7", "🏠  8", "🏠  9", "🏠  10"], 
                              ["🏠  11", "🏠  12", "🏠  13", "🏚  14", "🏠  15"], 
                              ["🏠  16", "🏠  17", "🏠  18", "🏠  19", "🏠  20"],
                              ["🏠  21", "🏠  22", "🏠  23", "🏠  24", "🏠  25"]])
    @@pastel = Pastel.new
    @@font = TTY::Font.new(:doom)
    @@player_reference = [@x, @y]
    @@bully_reference = [@bx, @by]
    @@visited = Array.new(2){Array.new(2)}
    @@current_game = nil

    def self.user=(user)
        @@user = user
    end

    def self.visited
        @@visited
    end

    def self.player_reference
        @@player_reference
    end

    def self.bully_reference
        @@bully_reference
    end

    def self.turns
        @@turns
    end

    def self.visited_coordinates
        @@visited
    end

    def self.title_screen
        system('clear')
        self.game_header #prints title screen
        self.auth_sequence
    end

    def self.game_header
        puts @@pastel.red(@@font.write("Trick or Treat !", letter_spacing: 1))
    end

    def self.auth_sequence
        prompt = TTY::Prompt.new

        selection = prompt.select("Choose an option from the menu below:") do |option|
            option.choice "Log In"
            option.choice "New User"
            option.choice "Delete User"
        end
        
        if selection == "Log In"
            @@user = User.login
            self.game_menu
        elsif selection == "New User"
            @@user = User.new_user
        elsif selection == "Delete User"
            User.delete_user
        end
    end

    
    def self.game_menu #displays the game menu for new or load after you log in or create a new user.
        sleep(1)
        system('clear')
        self.game_header
        prompt = TTY::Prompt.new

        selection = prompt.select("What would you like to do today?\n") do |option|
            option.choice "Ooh, ooh, I want to start a new game!!!\n"
            # option.choice "I suppose I had better finish one I've already started"
             option.choice "See High Scores"
        end
        
        if selection == "Ooh, ooh, I want to start a new game!!!\n"
            @@current_game = Game.new(user_id: @@user.id, game_complete: false, bag: [], visited_coordinates: [])
            # binding.pry
            Candy.game_candy
            self.gameboard
            self.prompt_user_movement
        elsif selection == "See High Scores"
             Game.display_highscores
             # self.title_screen
        end

        # elsif selection == "I suppose I had better finish one I've already started"
        #     self.load_game_sequence
            # Game.start_game(self.load_game_sequence)
    end
    

    # def self.load_game_sequence #Changes prompt choices from object locations, to their saved names
    #     load_prompt = TTY::Prompt.new
    #     sleep(1)
    #     system('clear')
    #     self.game_header
    #     load_selection = load_prompt.select("Which game would you like to load?\n", self.load_name)
    #         #prints the saved game names to the screen
    #         lga = Game.load(@@user).where(name: load_selection)
    #         binding.pry
    #         # @@current_game = Game.new(name: lga.name, user_id: )
    #     # binding.pry
    #         #current_game becomes the game with the same name and user_id as the current user.
    # end

    def self.load_name
        Game.load(@@user).map {|game| game.name}
    end

    def self.current_game
        @@current_game
    end


    #GENERATE GAME COMPONENTS:

    def self.generate_home
        #generates player home
        @@home = @@table[@hx = @x, @hy = @y]
    end
    
    def self.generate_player
        #takes coordinates from player home and assigns them
        #to @@player's coordinates
        
        @@player = @@table[@x = rand(0..4), @y = rand(0..4)]
    end

    def self.generate_bully
        #generates bully at a random location on the board. 
        @@bully = @@table[@bx = rand(0..4), @by = rand(0..4)] 
    end

    # def self.print_bully_loc
    #     puts "\nBe careful! The bully is at #{@@bully}!"
    #     @@bully
    # end

    # def self.print_player_loc
    #     puts "\nYou are at #{@@player}."
    #     @@player
    # end
    
    @@player = self.generate_player
    @@bully = self.generate_bully
    @@home = self.generate_home
   
    #GENERATES GAME BOARD
    def self.gameboard
        

        system('clear')
        self.game_header
        
        render = @@table.render(:ascii, padding: [1,2,1,2]) do |renderer| 
            renderer.border.separator = :each_row
            renderer.filter = ->(val, row_index, col_index) do
                #places bully emoji at bully location
                if row_index == @bx and col_index == @by
                    val = @@pastel.decorate("\n Bully 👿", :bold)
                else
                    val
                end
                #places user emoji at home location
                if row_index == @hx and col_index == @hy
                    val = @@pastel.decorate("\n 📍 HOME", :bold)
                else
                    val
                end
                #places emoji at user location
                if row_index == @x and col_index == @y
                    val = @@pastel.decorate("\n You 🎃", :bold)
                else
                    val
                end
                #emoji change when you get bullied
                if @x == @bx and @y == @by
                    val = @@pastel.decorate("\n 😵😵😵\n", :bold)
                else
                    val
                end

            end
            
        end

        #prints game board
        puts render

    end

   

        
    #PLAYER MOVES
    def self.player_move_up
        #checks that location is not out of bounds 
        if @x - 1 < 0
            new_loc = @@player
        else
            new_loc = @@table[@x= @x-1, @y]
        end
        self.player_movement(new_loc)
    end
    
    def self.player_move_down
        #checks that location is not out of bounds 
        if @x + 1 > 4 
            new_loc = @@player
        else
            new_loc = @@table[@x= @x+1, @y]
        end
        self.player_movement(new_loc)
    end
    
    def self.player_move_left
        #checks that location is not out of bounds 
        new_loc = @@player
        if @y - 1 < 0
            new_loc = @@player
        else
            new_loc = @@table[@x, @y=@y - 1]
        end
        self.player_movement(new_loc)
    end
    
    def self.player_move_right
        #checks that location is not out of bounds 
        if @y + 1 > 4 
            new_loc = @@player
        else
            #changes player location to new location
            new_loc = @@table[@x, @y=@y + 1]
        end
        self.player_movement(new_loc) 
    end

    #BULLY MOVES

    def self.bully_move_up
        #checks that location is not out of bounds 
        if @bx - 1 < 0
            new_loc = @@bully
        else
            new_loc = @@table[@bx = @bx - 1, @by]
        end
        self.bully_movement(new_loc)
    end
    
    def self.bully_move_down
        #checks that location is not out of bounds 
        if @bx + 1 > 4 
            new_loc = @@bully
        else
            new_loc = @@table[@bx = @bx + 1, @by]
        end
        self.bully_movement(new_loc)
    end
    
    def self.bully_move_left
        #checks that location is not out of bounds 
        new_loc = @@bully
        if @by - 1 < 0
            new_loc = @@bully
        else
            new_loc = @@table[@bx, @by=@by - 1]
        end
        self.bully_movement(new_loc)
    end
    
    def self.bully_move_right
        #checks that location is not out of bounds 
        if @by + 1 > 4 
            new_loc = @@bully
        else
            #changes player location to new location
            new_loc = @@table[@bx, @by=@by + 1]
        end
        self.bully_movement(new_loc) 
    end

    def self.bully_catches_player
        @@bully = @@table[@bx = @x, @by = @y]
    end

    def self.bully_move        
        case rand(0..7)
        
        when 0
            self.bully_move_right 
        when 1
            self.bully_move_left
        when 2
            self.bully_move_up
        when 3
            self.bully_move_down
        when 4
            self.bully_catches_player
        when 5
            self.bully_move_right 
        when 6
            self.bully_move_left
        when 7
            self.bully_move_up
        end
    end

    def self.bully_movement(location)
        #keeps player the same if location is out of bounds
        if location == @@bully
            @@bully = @@bully
        else
            #changes player location to new location
            @@bully = location
        end    
    end

    def self.player_movement(location)
        #keeps player the same if location is out of bounds
        if location == @@player
            @@player = @@player
        else
            #changes player location to new location
            @@player = location
        end    
    end
    
    def self.prompt_user_movement(turns=0, n=5)
        sleep(0.5)
        prompt = TTY::Prompt.new
        
        #repeats prompts for n turns
        n = 7
        @@turns = turns
        while @@turns < n do
            selection = prompt.select("Choose a direction:") do |option|
                option.choice "Up"
                option.choice "Down"
                option.choice "Left"
                option.choice "Right\n"
                # option.choice "Save Game"
            end

            if selection == "Up"
                system('clear')
                self.game_header
                if @@player != self.player_move_up
                    @@turns += 1
                    3.times do self.bully_move end
                end
                self.gameboard
        
            elsif selection == "Down"
                system('clear')
                self.game_header
                if @@player != self.player_move_down
                    @@turns += 1
                    3.times do self.bully_move end
                end
                self.gameboard
                
            elsif selection == "Left"
                system('clear')
                self.game_header
                if @@player != self.player_move_left
                    @@turns += 1
                    3.times do self.bully_move end
                end
                self.gameboard

            elsif selection == "Right\n"
                system('clear')
                self.game_header
                if @@player != self.player_move_right
                    @@turns += 1
                    3.times do self.bully_move end
                end
                self.gameboard
            end

            # elsif selection == "Save Game"
            #     Game.save_game(@@current_game)
            # end
            
            if @@turns < n 
                puts "\nYou have #{n-@@turns} turn(s) left.\n"
            end

            
            self.get_bullied
            self.end_game(n)

        end
    end

    def self.get_bullied
        if @@bully == @@player
            puts "\nThe bully caught you!\n"
            Candy.bully_robs_you
        else
            self.check_visited(@x,@y)
        end
    end

    def self.end_game(x)
        if @@turns == x
            puts "\nTrick or Treating is over! Let's see your haul!"
            puts "\nYou got #{Candy.sum_candies} points!"
            sleep(2)
            Game.save_game(@@current_game)
             
            Game.display_highscores
            
        end
    end
    
    def self.check_visited(x,y)
        
        has_visited = false
        @@visited.each do |subarray|
            if subarray[0] == x && subarray[1] == y
            has_visited = true
            end
        end
            
        if has_visited
            puts "\nYou have already visited this house."
        else
            puts "\nTrick or Treat!"
            @@visited << [x, y]
            #insert candy push method here
            Candy.bag_candy_by_id
        end

        # binding.pry
    end
    
end #CLI class



# # prompt.on(:keydown) {|value| value = "down"}
# # prompt.on(:keyleft) {|value| value = "left"}
# # prompt.on(:keyright) {|value| value = "right"}
#####################################################
# prompt.on(:keypress) do |key|
# #calls movement methods for each selection
# if event.key == :keyup
#     system('clear')
#     self.game_header
#     2.times do self.bully_move end
#     self.player_move_up
#     self.gameboard
#     turns += 1
# elsif event.key == :keydown
#     system('clear')
#     self.game_header
#     2.times do self.bully_move end
#     self.player_move_down
#     self.gameboard
#     turns += 1
# elsif event.key == :keyleft
#     system('clear')
#     self.game_header
#     2.times do self.bully_move end
#     self.player_move_left
#     self.gameboard
#     turns += 1
# elsif event.key == :keyright
#     system('clear')
#     self.game_header
#     2.times do self.bully_move end
#     self.player_move_right
#     self.gameboard
#     turns += 1
# end