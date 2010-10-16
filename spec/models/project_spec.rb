require 'spec_helper'

describe Project do
  it "generates the API token on creation" do
    @project = Project.create(:start => Date.today, :end => Date.today, :name => "Foo")
    @project.api_token.should_not be_blank
  end
  
  it "can regenerate the API token" do
    @project = Project.create(:start => Date.today, :end => Date.today, :name => "Foo")
    old_token = @project.api_token
    @project.regenerate_api_token
    @project.api_token.should_not == old_token
  end
end
