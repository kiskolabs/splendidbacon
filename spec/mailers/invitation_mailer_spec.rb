require "spec_helper"

describe InvitationMailer do
  before(:each) do
    organization = Organization.create(:name => "Kisko Labs")
    @email = "foo@example.org"
    @invitation = organization.invitations.create(:email => @email)
  end
  
  it "should send the invitation notification" do
    email = InvitationMailer.new_invitation(@invitation).deliver
    ActionMailer::Base.deliveries.should_not be_empty
    email.to.should == [@email]
    email.subject.should == "[Splendid Bacon] New invitation"
    email.encoded.should include("You have a new invitation to organization #{@invitation.organization.name}")
  end
end
