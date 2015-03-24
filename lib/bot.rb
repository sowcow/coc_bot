require 'forwardable'
require_relative 'bot/buildings'


# requires Game's deps: Navigation ...? FIXME
#
class Bot
  def initialize game
    @game = game
  end

  extend Forwardable
  delegate Navigation.instance_methods => :@game


  def buy order
    orders = order.chars.to_a
    actions = buildings.zip(orders).map { |building, order|
      building.order order
    }

    buy_sequential actions
  end

  private

  def buy_sequential actions
    actions = drop_unused_tail actions

    go_first_building

    # okish until repeated
    last = actions.drop(1).map { false } + [ true ]
    actions.zip(last).each { |action, last|
      action.perform @game

      go_next_building unless last
    }
    go_out_of_buildings
  end

  # no I'm not going to do it recursively!
  # it is good this way too
  #
  def drop_unused_tail things
    while things.last.unused?
      things = things[0...-1]
    end
    things
  end

  def buildings
    klasses =
      ([Barracks] * 4) +
      ([DarkBarracks] * 2) +
      [SpellFactory]
    klasses.map &:new
  end

  include Buildings
end
