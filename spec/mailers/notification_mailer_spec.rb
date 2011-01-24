require "spec_helper"

describe NotificationMailer do
  before(:each) do
    @project = "My Project"
    @organization = "Kisko Labs"
    @comment = "This is late!"
    @author = "Foo"
    @to = "foo@example.com"
  end
  
  it "sends the comment notification" do
    email = NotificationMailer.new_comment(@to, @project, 1, @organization, 1, @comment, @author).deliver
    ActionMailer::Base.deliveries.should_not be_empty
    email.to.should == [@to]
    email.subject.should == "[#{@project}] New comment from #{@author}"
    email.encoded.should include("made the following comment:")
    email.encoded.should include("This is late!")
  end
end
