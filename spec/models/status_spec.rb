require 'spec_helper'

describe Status do
  context "GitHub" do
    before(:each) do
      @user = User.create(:name => "Chris Wanstrath", :email => "chris@ozmm.org", :password => "123456")
      @organization = @user.organizations.create(:name => "Test")
      @project = @organization.projects.create({ :name => "GitHub", 
                                                 :start => Date.today - 7.days, 
                                                 :end => Date.today + 3.months, 
                                                 :state => :ongoing })

      github_payload = {
        before: "5aef35982fb2d34e9d9d4502f6ede1072793222d",
        repository: {
          url: "http://github.com/defunkt/github",
          name: "github",
          description: "You're lookin' at it.",
          watchers: 5,
          forks: 2,
          private: 1,
          owner: {
            email: "chris@ozmm.org",
            name: "defunkt"
          }
        },
        commits: [
          {
            id: "41a212ee83ca127e3c8cf465891ab7216a705f59",
            url: "http://github.com/defunkt/github/commit/41a212ee83ca127e3c8cf465891ab7216a705f59",
            author: {
              email: "chris@ozmm.org",
              name: "Chris Wanstrath"
            },
            message: "okay i give in",
            timestamp: "2008-02-15T14:57:17-08:00",
            added: ["filepath.rb"]
          },
          {
            id: "de8251ff97ee194a289832576287d6f8ad74e3d0",
            url: "http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0",
            author: {
              email: "hello@zachholman.com",
              name: "Zach Holman"
            },
            message: "update pricing a tad",
            timestamp: "2008-02-15T14:36:34-08:00"
          }
        ],
        after: "de8251ff97ee194a289832576287d6f8ad74e3d0",
        ref: "refs/heads/master"
      }.to_json
      
      @statuses = Status.create_from_github_payload(github_payload, @project)
    end
    
    it "creates new Statuses from a github JSON payload" do
      @project.statuses.count.should == 2
      @statuses.count.should == 2
      status = @statuses.find { |s| s.text == "okay i give in" }
      status.link.should == "http://github.com/defunkt/github/commit/41a212ee83ca127e3c8cf465891ab7216a705f59"
      
      status = @statuses.find { |s| s.text == "update pricing a tad" }
      status.link.should == "http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0"
    end
    
    it "associates a user with the status if a matching email is found" do
      status = @statuses.find { |s| s.text == "okay i give in" }
      status.user.should == @user
    end
    
    it "associates the project with the statuses" do
      @statuses.each do |status|
        status.project == @project
      end
    end
  end
end
