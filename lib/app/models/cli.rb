require "tty-prompt"
require "pry"
require "artii"


class Cli < ActiveRecord::Base
    @@prompt = TTY::Prompt.new

    def title_screen
        system('clear')


    end

end