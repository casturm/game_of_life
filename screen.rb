class Screen
  def self.draw(rows, cols, game, speed)
    print "\e[0;0H\e[1;37m\e[K"
    cols.times { print "---" }
    print "\n\r"
    print "\e[K   generation: #{game.generation}\n\r"
    print "\e[K   speed: #{speed}\e[0;34m\n\r"
    rows.times do |r|
      cols.times do
        print " --"
      end
      print "\e[K\n\r"
      cols.times do |c|
        print "|"
        if game.alive?([r,c])
          print "\u2638 "
        else
          print '  '
        end
      end
      print "\e[K|\n\r"
    end
    cols.times do
      print " --"
    end
    print "\r\n\e[K\n\r\e[K"
    game.tick
    sleep speed
  end
end
