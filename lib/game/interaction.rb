require_relative 'sikuli/sikuli'

module Interaction
  def click_hold target, secs: raise
    Sikuli.click_hold target, secs
  end

  def click *target
    Sikuli.click *target
  end
end
