class World
  attr_accessor :current_generation, :previous_generations
  def initialize
    @previous_generations = []
    @current_generation = Generation.new
  end
  def populate!(cells)
    @current_generation.populate!(cells)
  end
  def populate_from_pattern!(str)
    @current_generation.populate_from_pattern!(str)
  end
  def evolve!
    @previous_generations << @current_generation
    pgen = @current_generation
    @current_generation = Generation.new

    computed_cells = {}
    living_cells = []
    pgen.cells.each do |cell|
      (-1..1).each do |ix|
        (-1..1).each do |iy|
          next if ix==0 && iy==0
          newx=ix+cell.x
          newy=iy+cell.y
          next if computed_cells["#{newx}_#{newy}"]
          c=pgen.cell_at(newx,newy)
          next if c 
          c=Cell.new(newx, newy, pgen, false) 
          if(c.will_come_alive?)
            c.alive=true
            c.generation = nil
            living_cells << c
          end
          computed_cells["#{newx}_#{newy}"] = c
        end
      end
      living_cells << Cell.new(cell.x,cell.y) unless cell.will_die?
    end

    populate!(living_cells)
  end
end
