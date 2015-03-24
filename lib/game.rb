# explicitly owned and directed dependencies
# also explicitly visible acyclicity
#
require_relative 'game/assets'
require_relative 'game/interaction'
require_relative 'game/navigation'


class Game
  def initialize dir
    @assets = Assets.new dir
  end
  def the;  @assets  end

  include Interaction
  include Navigation
end
