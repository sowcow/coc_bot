require 'yaml'

task :default => :ui

task :ui do
  require 'dialog_tui'  # NOTE: a gem dependency
  include DialogTui

  require_relative 'lib/troop_configs'

  loop {

    dialog { |an|
      a = an

      troop_configs = TroopConfigs.new 'troop_configs.yml'
      troop_configs.each_ordered { |troop|
        an.option "buy: #{troop.name}" do

          # not an east oriented code, but ok i guess
          troop_configs.used troop
          ok = system './buy.sh %s' % troop.command
          exit unless ok
        end
      }

      an.option 'farm' do
        # TODO: do attack, move cursor to next button,
        #       activate clicker...
        begin
          system 'ruby clicker.rb' rescue nil
        rescue Interrupt => e
        end
        #puts 'done clicking...'
        #gets
      end

      a.ctrl_c do
        exit 0
      end

      a.before_draw do
        system 'clear'
      end
    }
  }
end

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
