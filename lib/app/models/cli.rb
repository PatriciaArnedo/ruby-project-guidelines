require "tty-prompt"
require "pry"
require "artii"


class Cli 
    @@prompt = TTY::Prompt.new
    @@artii = Artii::Base.new :font => 'slant'
    @@user = nil
    @@table = TTY::Table.new([["🏚  1", "🏠  2", "🏠  3", "🏚  4"], 
                              ["🏠  5", "🏠  6", "🏠  7", "🏠 8"], 
                              ["🏠  9", "🏠  10", "🏠  11", "🏠 12"], 
                              ["🏠  13", "🏚  14", "🏠  15", "🏠 16"]])

    def title_screen
        system('clear')
        puts @@artii.asciify("Trick or Treat!")
    end

    def auth_sequence
        sleep(2)



    end


    def gameboard
        #generates game board with separators
        render = @@table.render(:ascii, padding: [1,2,1,2]) do |renderer| 
            renderer.border.separator = :each_row
        end
        #prints game board
        puts render

    end

end