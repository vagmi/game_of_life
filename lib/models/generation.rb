class Generation
  attr_reader :offset
  def initialize
    @cells ||= Hash.new
    @offset = [0,0]
  end
  def population
    @cells.keys.count
  end
  def cells 
    @cells.values
  end
  def populate(cells)
    cells.each do |cell|
      @offset[0]= cell.x - 1 if cell.x-1<@offset[0] && cell.x<1
      @offset[1]= cell.y - 1 if cell.y-1<@offset[1] && cell.y<1
      @cells["#{cell.x}_#{cell.y}"]=cell
      cell.generation = self
    end
  end
  def populate_from_pattern(str)
    line_number = 1
    cells = []
    str.each_line do |line|
      char_pos = 1
      line.split('').each do |c|
        cells << Cell.new(line_number,char_pos) if c=="*"
        char_pos = char_pos +1
      end
      line_number=line_number + 1
    end
    populate(cells)
  end
  def cell_at(x,y,use_offset=false)
    return @cells["#{x}_#{y}"] unless use_offset
    @cells["#{x+@offset[0]}_#{y+@offset[1]}"]
  end
  def cell_at_offset(x,y)
    cell_at(x,y,true)
  end
end
