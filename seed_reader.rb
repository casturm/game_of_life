require 'CSV'

class SeedReader
  def initialize(file)
    @file = file
  end

  def lines(&block)
    CSV.foreach(@file) do |line|
      yield line if block
    end
  end

  def rows
    rows = 0
    lines { rows = rows + 1 }
    rows
  end

  def cols
    cols = Array.new
    lines do |line|
      cols << line.size
    end
    raise "columns mismatch #{cols}" if cols.uniq.size > 1
    cols[0]
  end

  def parse
    lines = Array.new
    lines do |line|
      lines << line
    end
    seed = Array.new
    lines.each_with_index do |line, r|
      line.each_with_index do |value, c|
        seed << [r, c] if value == 'x'
      end
    end
    seed
  end
end
