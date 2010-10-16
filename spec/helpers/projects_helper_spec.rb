require 'spec_helper'

describe ProjectsHelper do

  before(:each) do
    Date.stub!(:today).and_return(Date.new(2010, 1, 20)) # Wednesday    
  end

  describe "width" do

    it "is the duration of the project in days multiplied by 8px" do
      project = Project.new(:start => Date.today, :end => (Date.today + 10))
      helper.width(project).should == 11 * 8
    end

    it "always contains the two weeks before" do
      Date.stub!(:today).and_return(Date.new(2010, 1, 20)) # Wednesday

      project = Project.new(:start => (Date.today - 5), :end => (Date.today + 10))
      helper.width(project).should == 16 * 8

      project = Project.new(:start => Date.new(2010, 1, 1), :end => (Date.today + 10))
      helper.width(project).should == 27 * 8
    end
    
  end

  describe "left margin" do
  
    it "is 0 if the project started before the two earlier weeks" do
      project = Project.new(:start => Date.today - 100)
      helper.left_margin(project).should == 0

      project = Project.new(:start => Date.new(2010, 1, 4))
      helper.left_margin(project).should == 0
    end

    it "is positive if the project start date is in the timeline" do
      project = Project.new(:start => Date.new(2010, 1, 5))
      helper.left_margin(project).should == 8

      project = Project.new(:start => Date.today)
      helper.left_margin(project).should == 16 * 8
    end

  end

end
