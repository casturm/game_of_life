require 'CSV'

class SeedReader
  attr_reader :seed

  def initialize(file)
    @seed = Array.new
    if file.nil?
      @seed << [5,5]
    else
      CSV.foreach(file) do |row|
        @seed << row.map(&:chomp).map(&:to_i)
      end
    end
  end
end
