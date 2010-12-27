require 'spec_helper'

describe Project do
  it "generates the API token on creation" do
    @project = Project.create(:start => Date.today, :end => Date.today, :name => "Foo", :state => "ongoing")
    @project.api_token.should_not be_blank
  end
  
  it "can regenerate the API token" do
    @project = Project.create(:start => Date.today, :end => Date.today, :name => "Foo", :state => "ongoing")
    old_token = @project.api_token
    @project.regenerate_api_token
    @project.api_token.should_not == old_token
  end
  
  describe "#guest_access?" do
    subject { Project.new(:start => Date.today, :end => Date.today, :name => "Foo", :state => "ongoing") }

    it "returns true if guest token is set" do
      subject.enable_guest_access
      subject.guest_access?.should be_true
    end

    it "returns false if guest token is not set" do
      subject.guest_access?.should be_false
    end
  end

  describe "#authenticate_guest_access" do
    subject { Project.new(:start => Date.today, :end => Date.today, :name => "Foo", :state => "ongoing") }

    it "returns false if guest access is not on" do
      subject.authenticate_guest_access("abc").should be_false
    end

    it "returns false if guest token is incorrect" do
      subject.enable_guest_access
      subject.authenticate_guest_access("abc").should be_false
    end

    it "returns true if token is correct" do
      subject.enable_guest_access
      subject.authenticate_guest_access(subject.guest_token).should be_true
    end
  end

  describe "#enable_guest_access" do
    subject { Project.new(:start => Date.today, :end => Date.today, :name => "Foo", :state => "ongoing") }

    it "sets guest token" do
      subject.guest_token.should be_blank
      subject.enable_guest_access
      subject.guest_token.should_not be_blank
    end
  end

  describe "#disable_guest_access" do
    subject { Project.new(:start => Date.today, :end => Date.today, :name => "Foo", :state => "ongoing") }

    it "unsets guest token" do
      subject.enable_guest_access
      subject.guest_token.should_not be_blank
      subject.disable_guest_access
      subject.guest_token.should be_blank
    end
  end

  describe "#state" do
    it "always returns symbols" do
      @project = Project.new
      @project.state = "ongoing"
      @project.state.should be(:ongoing)
    end
  end

  describe "#state_name" do
    it "returns correct value for all 3 valid states" do
      @project = Project.new
      @project.state = "ongoing"
      @project.state_name.should == "Ongoing"
      @project.state = "on_hold"
      @project.state_name.should == "On Hold"
      @project.state = "completed"
      @project.state_name.should == "Completed"
    end
  end

  describe "#active?" do
    before do
      @project = Project.new
    end

    it "returns true if project is on going" do
      @project.state = "ongoing"
      @project.active?.should be_true
    end

    it "returns false if project is on hold" do
      @project.state = "on_hold"
      @project.active?.should be_false
    end

    it "returns false if project is completed" do
      @project.state = "completed"
      @project.active?.should be_false
    end
  end

  describe "#completed?" do
    before do
      @project = Project.new
    end

    it "returns true if project is completed" do
      @project.state = "completed"
      @project.completed?.should be_true
    end

    it "returns false if project is on hold" do
      @project.state = "on_hold"
      @project.completed?.should be_false
    end

    it "returns false if project is ongoing" do
      @project.state = "ongoing"
      @project.completed?.should be_false
    end
  end
end
