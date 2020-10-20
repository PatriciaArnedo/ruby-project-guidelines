require "tty-prompt"
require "pry"
require "artii"


class Cli 
    @@prompt = TTY::Prompt.new
    @@artii = Artii::Base.new :font => 'slant'
    @@user = nil

    def title_screen
        system('clear')
        puts @@artii.asciify("Trick or Treat!")
    end

    def auth_sequence
        sleep(2)



    end


    def gameboard

    end

end