require 'ruby-progressbar'

END { main }


# just clicks mouse button
#
def click
  system 'xdotool click 1'  # NOTE dependency
end


# just clicks mouse button periodically
#
def main
  secs = 5

  $bar = ProgressBar.create total: secs + 1 # so that it never gets to 100%
  # global is kisser than a class here!

  loop do
    wait secs
    click
  end
end

def wait num
  $bar.progress = 0
  num.times {
    sleep 1
    $bar.increment
  }
end
