$:<< '/opt/sikuli-ide'
# NOTE: this path is for my Arch, customize if needed!
# NOTE: the path is to sikuli-script.jar file


require 'java'
require 'sikuli-script.jar'

module Sikuli
  %w[
    Finder
    Screen
    App
    Pattern
    Key
    KeyModifier
    Location
    Button
  ].each { |x| java_import "org.sikuli.script.#{x}" }


  # omg can't access sikulis Button.LEFT
  java_import 'java.awt.event.InputEvent'
  LEFT = InputEvent::BUTTON1_MASK

  module_function

  def activate title_part
    App.new(title_part).focus
  end

  def click *given
    given = given.flatten
    
    case given.size
    when 1
      pattern, _ = given
      click_pattern pattern
    when 2
      x, y = given
      click_point x, y
    else raise
    end
  end

  TIMEOUT_SECS = 3

  def click_point x, y
    point = Location.new x, y
    s = Screen.new
    s.click point
  end

  def click_pattern pattern
    s = Screen.new
    s.wait pattern   # to raise exception
    s.click pattern  # if not found
  end

  def click_hold pattern, secs
    raise 'todo when needed' if pattern.kind_of? Array
    s = Screen.new

    s.mouse_move pattern
    s.mouse_down LEFT
    sleep secs
    s.mouse_up LEFT
  end

end
