task :buy, :orders do |_, params|
                                         # order matters
  params.with_defaults orders: 'bbaa--h' # two barracks of barbs
  stuff = params[:orders]                # two of archers
                                         # no orders for dark troops
                                         # heling spells

  require_relative 'lib/game'
  require_relative 'lib/bot'
  
  game = Game.new 'coc'
  game.activate
  Bot.new(game).buy stuff

  # Game#activate is:
  #
  # a vague defined action that depends on user
  # user should run emulator in a known reproducible state
  #
  # on my machine it is fullscreen on a home base screen
  # zoomed-out to the NW
  #
  # and currently requires game to be in "live" mode
  # (not in "press reload button when returned" mode)
end
