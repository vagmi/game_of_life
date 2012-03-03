class Cell
  attr_accessor :x, :y, :generation, :alive
  def initialize(x=0,y=0, generation=nil, alive=true)
    @x=x
    @y=y
    @generation = generation
    @alive = alive
  end
  def neighbors
    @neighbor_cells = []
    (-1..1).each do |ix|
      (-1..1).each do |iy|
        c=generation.cell_at(x+ix,y+iy) unless ix==0 && iy==0
        @neighbor_cells << c if c
      end
    end
    @neighbor_cells
  end
  def will_come_alive?
    n=self.neighbors
    (not @alive) && n.count==3
  end
  def will_die?
    @alive && (neighbors().count > 3 || neighbors().count < 2)
  end
  def status
    @alive ? "kicking" : "dead"
  end
  def to_s
    "at #{x},#{y} and #{status}"
  end
end
