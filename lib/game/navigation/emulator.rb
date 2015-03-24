# hm...
#
require_relative '../sikuli/sikuli'

module Emulator
  # stuff to notice and may be to change goes first:
  #
  TITLE_PART = 'Genymotion'

  module_function

  def activate
    Sikuli.activate TITLE_PART
  end
end
