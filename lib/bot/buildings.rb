require_relative 'buildings/order'


module Buildings

  class Building

    def order sign
      case sign
      when ?-
        Order.new unused: true
      else
        send "order_#{sign}"
      end
    end
  end

  class Barracks < Building
    def order_b
      Order.new do
        click_hold the.barbs, secs: 3
      end
    end

    def order_a
      Order.new do
        click_hold the.archers, secs: 3
      end
    end
  end

  class DarkBarracks < Building
    def order_m
      Order.new do
        click_hold the.minions, secs: 3
      end
    end
  end

  class SpellFactory < Building
    def order_h
      Order.new do
        click_hold the.heal_spell, secs: 1
      end
    end
  end

end







__END__
require_relative 'assets'
require_relative 'interaction'
require_relative 'navigation'


class Game
  def initialize dir
    @assets = Assets.new dir
  end
  def the;  @assets  end

  include Interaction
  include Navigation
end


module Coc
  class Order
    def initialize unused: false, &block
      @unused = unused
      @perform = block
      raise "hey, this order is'nt implemented!" \
        unless block
    end

    def unused?; @unused end

    def perform somewhere
      somewhere.instance_eval &@perform
    end
  end

end
