require 'spec_helper'
describe Generation do
  subject { Generation.new }
  describe "#populate" do
    before do
      @cells = []
      @cells << Cell.new(1,1)
      @cells << Cell.new(1,2)
      @cells << Cell.new(2,1)
      @cells << Cell.new(2,2)
    end
    it "should populate the current generation with given cells" do
      subject.populate @cells
      subject.population.should == 4
      subject.cell_at(1,1).should_not be_nil
      subject.cell_at(1,2).should_not be_nil
      subject.cell_at(2,1).should_not be_nil
      subject.cell_at(2,2).should_not be_nil
    end
    it "should set the current generation for the cell" do
      subject.populate @cells
      @cells.each do |c|
        c.generation.should == subject
      end
    end
  end
  describe "#populate_from_pattern" do
    before do
      @block_pattern = File.read(File.join(FIXTURES_PATH,"block.pattern"))
      @boat_pattern= File.read(File.join(FIXTURES_PATH,"boat.pattern"))
    end
    it "should load the block pattern" do
      subject.populate_from_pattern(@block_pattern)
      subject.population.should == 4
      subject.cell_at(1,1).should_not be_nil
      subject.cell_at(1,2).should_not be_nil
      subject.cell_at(2,1).should_not be_nil
      subject.cell_at(2,2).should_not be_nil
    end
    it "should load the boat pattern" do
      subject.populate_from_pattern(@boat_pattern)
      subject.population.should == 5
      subject.cell_at(1,1).should_not be_nil
      subject.cell_at(1,2).should_not be_nil
      subject.cell_at(1,3).should be_nil
      subject.cell_at(2,1).should_not be_nil
      subject.cell_at(2,2).should be_nil
    end
  end
end
