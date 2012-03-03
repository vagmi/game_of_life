require 'spec_helper'
describe Cell do
  describe "#neighbors" do
    before do
      @world = World.new
      @world.populate_from_pattern!(File.read(File.join(FIXTURES_PATH,'block.pattern')))
    @cell = @world.current_generation.cell_at(1,1)
    end
    it "should have neighbors" do
      @cell.neighbors.count.should == 3
      @cell.neighbors.index(@world.current_generation.cell_at(1,2)).should_not be_nil
      @cell.neighbors.index(@world.current_generation.cell_at(2,1)).should_not be_nil
      @cell.neighbors.index(@world.current_generation.cell_at(2,2)).should_not be_nil
    end
  end
  describe "#will_come_alive?" do
    subject { Cell.new(0,0,nil,false) }
    context "when there are less than three neighbors" do
      before do
        subject.stub(:neighbors).and_return([1,2])
      end
      it "should be false" do
        subject.will_come_alive?.should == false
      end
    end
    context "when there are three neighbors" do
      before do
        subject.stub(:neighbors).and_return([1,2,3])
      end
      it "should be true" do
        subject.will_come_alive?.should be_true 
      end
    end
  end

  describe "#will_die?" do
    subject { Cell.new }
    context "when there are less than two neighbors" do
      before do
        subject.stub(:neighbors).and_return([1])
      end
      it "should be true" do
        subject.will_die?.should be_true
      end
    end
    context "when there are more than three neighbors" do
      before do
        subject.stub(:neighbors).and_return([1,2,3,4])
      end
      it "should be true" do
        subject.will_die?.should be_true
      end
    end
    context "when there are two neighbors" do
      before do
        subject.stub(:neighbors).and_return([1,2])
      end
      it "should be false" do
        subject.will_die?.should be_false
      end
    end
    context "when there are three neighbors" do
      before do
        subject.stub(:neighbors).and_return([1,2,3])
      end
      it "should be false" do
        subject.will_die?.should be_false
      end
    end
  end
end
