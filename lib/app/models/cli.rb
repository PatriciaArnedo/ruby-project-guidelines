require "tty-prompt"
require "pry"
require "tty-cursor"
require "tty-font"


class CLI 
    @@prompt = TTY::Prompt.new
    @@user = nil
    @@table = TTY::Table.new([["0", "1", "2", "3", "4"],
                              ["1", "🏚  1", "🏠  2", "🏠  3", "🏚  4"], 
                              ["2", "🏠  5", "🏠  6", "🏠  7", "🏠 8"], 
                              ["3", "🏠  9", "🏠  10", "🏠  11", "🏠 12"], 
                              ["4", "🏠  13", "🏚  14", "🏠  15", "🏠 16"]])
    @@pastel = Pastel.new
    @@font = TTY::Font.new(:doom)

    def self.title_screen
        system('clear')
        self.game_header #prints title screen
        self.auth_sequence
    end

    def self.game_header
        puts @@pastel.red(@@font.write("Trick or Treat !", letter_spacing: 1))
    end

    def self.auth_sequence
        sleep(1)
        prompt = TTY::Prompt.new

        selection = prompt.select("Choose an option from the menu below:") do |option|
            option.choice "Log In"
            option.choice "New User"
            option.choice "Delete User"
        end
        
        if selection == "Log In"
            @@user = User.login
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
            option.choice "I suppose I had better finish one I've already started"
        end
        
        if selection == "Ooh, ooh, I want to start a new game!!!\n"
            @@current_game = Game.new(user_id: @@user.id, game_complete: false)
            binding.pry
            Game.start_game(@@current_game)
        elsif selection == "I suppose I had better finish one I've already started"
            # self.load_game_sequence
            Game.start_game(self.load_game_sequence)
        end
    end
    

    def self.load_game_sequence #Changes prompt choices from object locations, to their saved names
        load_prompt = TTY::Prompt.new
        sleep(1)
        load_selection = load_prompt.select("Which game would you like to load?\n", self.load_name)
            #prints the saved game names to the screen
        @@current_game = Game.load(@@user).where(name: load_selection)
            #current_game becomes the game with the same name and user_id as the current user.
    end

    def self.load_name
        Game.load(@@user).map {|game| game.name}
    end



    #PLAYER MOVEMENT LOGIC METHODS:

    def self.generate_player
        #generates player at a random location on the board. 
        @@player = @@table[@x = rand(1..4),@y = rand(1..4)]
    end

    def self.generate_bully
        #generates bully at a random location on the board. 
        @@bully = @@table[@bx = rand(1..4), @by = rand(1..4)] 
    end

    def self.print_bully_loc
        puts "Be careful! The bully is at #{@@bully}!"
        @@bully
    end

    def self.print_player_loc
        puts "You are at #{@@player}."
        @@player
    end
    
    @@player = self.generate_player
    @@bully = self.generate_bully

    def self.gameboard
        #generates game board with separators
        system('clear')
        self.game_header
        render = @@table.render(:ascii, padding: [1,2,1,2]) do |renderer| 
            renderer.border.separator = :each_row
            renderer.filter = ->(val, row_index, col_index) do
                if row_index == @x and col_index == @y
                    val = "\n You 👻"
                else
                    val
                end
                if row_index == @bx and col_index == @by
                    val = "\n Bully 👿"
                else
                    val
                end
            end
            
        end

        #prints game board
        puts render
        self.print_player_loc
        self.print_bully_loc
    end
        
    
    def self.player_move_up
        #checks that location is not out of bounds 
        if @x - 1 < 1 
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
        if @y - 1 < 1 
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

    def self.bully_move_up
        #checks that location is not out of bounds 
        if @bx - 1 < 1 
            new_loc = @@bully
        else
            new_loc = @@bully[@bx = @bx - 1, @by]
        end
        self.bully_movement(new_loc)
    end
    
    def self.bully_move_down
        #checks that location is not out of bounds 
        if @bx + 1 > 4 
            new_loc = @@bully
        else
            new_loc = @@bully[@bx = @bx + 1, @by]
        end
        self.bully_movement(new_loc)
    end
    
    def self.bully_move_left
        #checks that location is not out of bounds 
        new_loc = @@bully
        if @by - 1 < 1 
            new_loc = @@bully
        else
            new_loc = @@bully[@bx, @by=@by - 1]
        end
        self.bully_movement(new_loc)
    end
    
    def self.bully_move_right
        #checks that location is not out of bounds 
        if @by + 1 > 4 
            new_loc = @@bully
        else
            #changes player location to new location
            new_loc = @@bully[@bx, @by=@by + 1]
        end
        self.bully_movement(new_loc) 
    end

    def self.randomize_bully_mvmnt
        array = [
                 self.bully_move_right, 
                 self.bully_move_left,
                 self.bully_move_up,
                 self.bully_move_down
                ]
            array.sample
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
    
    def self.prompt_user_movement
        sleep(0.5)
        prompt = TTY::Prompt.new
        
        #repeats prompts for n turns
        turns = 0
        while turns <= 10 do
            selection = prompt.select("Choose a direction:") do |option|
                option.choice "Up"
                option.choice "Down"
                option.choice "Left"
                option.choice "Right"
            end
            
            #calls movement methods for each selection
            if selection == "Up"
                system('clear')
                self.game_header
                #self.randomize_bully_mvmnt
                self.player_move_up
                self.gameboard
            elsif selection == "Down"
                system('clear')
                self.game_header
                #self.randomize_bully_mvmnt
                self.player_move_down
                self.gameboard
            elsif selection == "Left"
                system('clear')
                self.game_header
                #self.randomize_bully_mvmnt
                self.player_move_left
                self.gameboard
            elsif selection == "Right"
                system('clear')
                self.game_header
                #self.randomize_bully_mvmnt
                self.player_move_right
                self.gameboard
            end
            #increments turns
            turns +=1
        end
    end

    
    
    

end #CLI class


