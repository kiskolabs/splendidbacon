require 'spec_helper'

describe Status do
  context "GitHub" do
    before(:each) do
      @user = User.create(:name => "Chris Wanstrath", :email => "chris@ozmm.org", :password => "12345678")
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
    
    it "creates new statuses from a GitHub JSON payload" do
      @statuses.count.should == 2
      @project.statuses.count.should == 3
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
  
  context "Pivotal Tracker" do
    before(:each) do
      @project = Project.create({ :name => "Pivotal Tracker", 
                                  :start => Date.today - 7.days, 
                                  :end => Date.today + 3.months, 
                                  :state => :ongoing })
      
      @story_update = %(<?xml version="1.0" encoding="UTF-8"?>
                        <activity>
                          <id type="integer">1031</id>
                          <version type="integer">175</version>
                          <event_type>story_update</event_type>
                          <occurred_at type="datetime">2009/12/14 14:12:09 PST</occurred_at>
                          <author>James Kirk</author>
                          <project_id type="integer">26</project_id>
                          <description>James Kirk accepted &quot;More power to shields&quot;</description>
                          <stories>
                            <story>
                              <id type="integer">109</id>
                              <url>https://projects/26/stories/109</url>
                              <accepted_at type="datetime">2009/12/14 22:12:09 UTC</accepted_at>
                              <current_state>accepted</current_state>
                            </story>
                          </stories>
                        </activity>)
      
      @story_create = %(<?xml version="1.0" encoding="UTF-8"?>
                        <activity>
                          <id type="integer">1031</id>
                          <version type="integer">175</version>
                          <event_type>story_create</event_type>
                          <occurred_at type="datetime">2009/12/14 14:12:09 PST</occurred_at>
                          <author>James Kirk</author>
                          <project_id type="integer">26</project_id>
                          <description>James Kirk created new shields</description>
                          <stories>
                            <story>
                              <id type="integer">110</id>
                              <url>https://projects/26/stories/110</url>
                              <accepted_at type="datetime">2009/12/14 22:12:09 UTC</accepted_at>
                              <current_state>accepted</current_state>
                            </story>
                          </stories>
                        </activity>)
      @story_random = %(<?xml version="1.0" encoding="UTF-8"?>
                        <activity>
                          <id type="integer">1031</id>
                          <version type="integer">175</version>
                          <event_type>story_random</event_type>
                          <occurred_at type="datetime">2009/12/14 14:12:09 PST</occurred_at>
                          <author>James Kirk</author>
                          <project_id type="integer">26</project_id>
                          <description>The entropy is sky high!</description>
                          <stories>
                            <story>
                              <id type="integer">111</id>
                              <url>https://projects/26/stories/111</url>
                              <accepted_at type="datetime">2009/12/14 22:12:09 UTC</accepted_at>
                              <current_state>accepted</current_state>
                            </story>
                          </stories>
                        </activity>)
    end
    
    it "creates a new status from the Pivotal Tracker XML payload" do
      status = Status.create_from_pivotal_tracker_payload(@story_update, @project)
      status.text.should == "James Kirk accepted \"More power to shields\""
      status.link.should == "https://projects/26/stories/109"
      status.source.should == "Pivotal Tracker"
      
      status = Status.create_from_pivotal_tracker_payload(@story_create, @project)
      status.text.should == "James Kirk created new shields"
      status.link.should == "https://projects/26/stories/110"
      status.source.should == "Pivotal Tracker"
    end
    
    it "associates a project with the status" do
      status = Status.create_from_pivotal_tracker_payload(@story_update, @project)
      status.project.should == @project
    end
    
    it "creates a new status when the event type is 'story_update'" do
      status = Status.create_from_pivotal_tracker_payload(@story_update, @project)
      status.text.should == "James Kirk accepted \"More power to shields\""
    end
    
    it "creates a new status when the event type is 'story_create'" do
      status = Status.create_from_pivotal_tracker_payload(@story_create, @project)
      status.text.should == "James Kirk created new shields"
    end
      
    it "does not create a new status when the event type is not 'story_update' or 'story_create'" do
      status = Status.create_from_pivotal_tracker_payload(@story_random, @project)
      status.should be_nil
    end
  end
end
