require 'spec_helper'
describe World do
  subject { World.new }
  
  describe "#current_generation" do
    it "has a current generation" do
      subject.respond_to?(:current_generation).should be_true
      subject.current_generation.is_a?(Generation).should be_true
    end
  end

  describe "#evolve" do
    describe "box pattern" do
      before do
        @pattern = File.read(File.join(FIXTURES_PATH,"block.pattern"))
        subject.populate_from_pattern(@pattern)
        @old_generation = subject.current_generation
      end
      it "should evolve into the same pattern" do
        subject.evolve
        subject.previous_generations.last.should == @old_generation
        subject.current_generation.should_not == subject.previous_generations.last
        subject.current_generation.cell_at(1,1).should_not be_nil
        subject.current_generation.cell_at(1,2).should_not be_nil
        subject.current_generation.cell_at(2,1).should_not be_nil
        subject.current_generation.cell_at(2,2).should_not be_nil

      end
    end
    describe "boat pattern" do
      before do
        @pattern = File.read(File.join(FIXTURES_PATH,"boat.pattern"))
        subject.populate_from_pattern(@pattern)
        @old_generation = subject.current_generation
      end
      it "should evolve into the same pattern" do
        subject.evolve
        subject.previous_generations.last.should == @old_generation
        subject.current_generation.should_not == subject.previous_generations.last
        subject.current_generation.population.should == 5
        subject.current_generation.cell_at(1,1).should_not be_nil
        subject.current_generation.cell_at(1,2).should_not be_nil
        subject.current_generation.cell_at(1,3).should be_nil
        subject.current_generation.cell_at(2,1).should_not be_nil
        subject.current_generation.cell_at(2,2).should be_nil
        subject.current_generation.cell_at(2,3).should_not be_nil
        subject.current_generation.cell_at(3,1).should be_nil
        subject.current_generation.cell_at(3,2).should_not be_nil
        subject.current_generation.cell_at(3,3).should be_nil

      end
    end
    describe "blinker pattern" do
      before do
        @pattern = File.read(File.join(FIXTURES_PATH,"blinker.pattern"))
        subject.populate_from_pattern(@pattern)
        @old_generation = subject.current_generation
      end
      it "should flip vertically" do
        subject.evolve
        subject.previous_generations.last.should == @old_generation
        subject.current_generation.should_not == subject.previous_generations.last
        subject.current_generation.population.should == 3
        subject.current_generation.cell_at(1,1).should be_nil
        subject.current_generation.cell_at(1,2).should_not be_nil
        subject.current_generation.cell_at(1,3).should be_nil
        subject.current_generation.cell_at(2,1).should be_nil
        subject.current_generation.cell_at(2,2).should_not be_nil
        subject.current_generation.cell_at(2,3).should be_nil
        subject.current_generation.cell_at(3,1).should be_nil
        subject.current_generation.cell_at(3,2).should_not be_nil
        subject.current_generation.cell_at(3,3).should be_nil

      end
      it "should return to normal when evolved twice" do
        subject.evolve
        subject.evolve
        subject.current_generation.population.should == 3
        subject.current_generation.cell_at(1,1).should be_nil
        subject.current_generation.cell_at(1,2).should be_nil
        subject.current_generation.cell_at(1,3).should be_nil
        subject.current_generation.cell_at(2,1).should_not be_nil
        subject.current_generation.cell_at(2,2).should_not be_nil
        subject.current_generation.cell_at(2,3).should_not be_nil
        subject.current_generation.cell_at(3,1).should be_nil
        subject.current_generation.cell_at(3,2).should be_nil
        subject.current_generation.cell_at(3,3).should be_nil
      end
    end
    describe "toad pattern" do
      before do
        @pattern = File.read(File.join(FIXTURES_PATH,"toad.pattern"))
        subject.populate_from_pattern(@pattern)
        @old_generation = subject.current_generation
      end
      it "should evolve into the same pattern" do
        subject.evolve
        subject.previous_generations.last.should == @old_generation
        subject.current_generation.should_not == subject.previous_generations.last
        subject.current_generation.population.should == 6
        subject.current_generation.cell_at_offset(1,1).should be_nil
        subject.current_generation.cell_at_offset(1,2).should be_nil
        subject.current_generation.cell_at_offset(1,3).should_not be_nil
        subject.current_generation.cell_at_offset(1,4).should be_nil

        subject.current_generation.cell_at_offset(2,1).should_not be_nil
        subject.current_generation.cell_at_offset(2,2).should be_nil
        subject.current_generation.cell_at_offset(2,3).should be_nil
        subject.current_generation.cell_at_offset(2,4).should_not be_nil
        
        subject.current_generation.cell_at_offset(3,1).should_not be_nil
        subject.current_generation.cell_at_offset(3,2).should be_nil
        subject.current_generation.cell_at_offset(3,3).should be_nil
        subject.current_generation.cell_at_offset(3,4).should_not be_nil
        
        subject.current_generation.cell_at_offset(4,1).should be_nil
        subject.current_generation.cell_at_offset(4,2).should_not be_nil
        subject.current_generation.cell_at_offset(4,3).should be_nil
        subject.current_generation.cell_at_offset(4,4).should be_nil
      end
    end
  end
end
