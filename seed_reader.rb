require 'CSV'

class SeedReader
  attr_reader :rows
  attr_reader :cols
  attr_reader :seed

  def initialize(file)
    seed = Array.new
    values = CSV.foreach(file) do |row|
      puts "#{row}"
      seed << row.map(&:to_i)
    end
    puts "#{seed}"
    @rows = seed[0][0]
    @cols = seed[0][1]
    @seed = seed.drop(1)
    puts "#{@rows} #{@cols} #{@seed}"
  end
end
