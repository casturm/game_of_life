require 'time'
require 'ruby-prof'
require_relative 'game'
require_relative 'seed_reader'
STDOUT.sync = true

reader = SeedReader.new(ARGV[0])
control_file = ARGV[1]

def controls(control_file)
  controls = [0.2]
  unless control_file.nil?
    controls = File.read(control_file).split(',').map {|control| control.chomp.to_f}
  end
  controls
end

def print_screen(rows, cols, game, speed)
  print "\e[1;37m"
  print "\tgeneration: #{game.generation}\tspeed: #{speed}\n"
  print "\e[0;34m"
  rows.times do |r|
    cols.times do
      print " --"
    end
    print "\n\r"
    cols.times do |c|
      print "|"
      if game.alive?([r,c])
        print "\u2638 "
      else
        #print "#{r},#{c}"
        print '  '
      end
    end
    print "|\n\r"
  end
  cols.times do
    print " --"
  end
  print "\n\r"
  sleep speed
  print "\e[#{(rows*2)+2}A\r"
  game.tick
end

seed = reader.seed
rows = reader.rows
cols = reader.cols
game = Game.new(seed)
print '|'
cols.times do
  print "---"
end
print "|\n\r"
begin
  RubyProf.start
  loop do
    print_screen(rows, cols, game, controls(control_file)[0])
  end
rescue Interrupt => exc
end
if exc
  result = RubyProf.stop
  printer = RubyProf::GraphHtmlPrinter.new(result)
  #printer.print(File.new('resutls.html','w'), :min_percent=>0)
  puts "\r\e[1;37mBye!"
end
