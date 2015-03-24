# abstract dir name means this one is shared
# and also it does not depend on stuff out of the dir...
#
require_relative 'sikuli/sikuli'
require_relative 'navigation/emulator'

module Navigation

  def go_first_building
    click the.first_barracks
    click the.train_troops
    # click.button.name ...
  end

  def go_next_building
    click the.next_building
  end

  def go_out_of_buildings
    click the.close_building
    click the.ground
  end

  def activate
    Emulator.activate
  end
end
