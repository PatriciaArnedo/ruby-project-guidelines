require_relative '../config/environment'

cli = Cli.new

cli.title_screen
cli.gameboard
cli.generate_player
cli.generate_bully
cli.move_up


