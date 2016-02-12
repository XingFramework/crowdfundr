require 'spec_helper'

describe ProjectSerializer, :type => :serializer do

  let :user do
    FactoryGirl.create(:user)
  end

  let! :project do
    FactoryGirl.create(:project,
                       :name => "The Xing Framework",
                       :description => "Cool new web framework!",
                       :deadline => Date.today + 30.days,
                       :goal => 15000.00,
                       :user => user
                      )
  end

  let :serializer do
    ProjectSerializer.new(project)
  end

  describe "as_json" do
    let :json do serializer.to_json end

    it "should have the correct links" do
      expect(json).to be_json_string("/projects/#{project.id}").
        at_path("links/self")
    end

    it "should have the correct structure and content" do
      expect(json).to be_json_string("The Xing Framework").
        at_path("data/name")
      expect(json).to be_json_string("Cool new web framework!").
        at_path("data/description")
      expect(json).to be_json_string(project.deadline.as_json).
        at_path("data/deadline")
      expect(json).to be_json_string("15000.00").
        at_path("data/goal")
      expect(json).to be_json_eql(user.id).
        at_path("data/user_id")

    end
  end
end
