task :buy do

  stuff = 'bbaammh' # stuff to buy
                    # in most human usable form
  # those not in game will not understand this
  # but they aren't gona use it anyway

  require_relative 'lib/game'
  require_relative 'lib/bot'
  
  game = Game.new 'coc'
  game.activate
    # vague defined action that depends on user
    # user should run emulator in a known state
    #
    # on my machine it is fullscreen on a home base screen
    # zoomed-out to the NW
    #
    # and currently requires game to be in "live" mode
    # (not in "press reload button when returned" mode)
  
  Bot.new(game).buy stuff
end
