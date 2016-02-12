require 'spec_helper'

describe ProjectListSerializer, :type => :serializer do

  let! :project_1 do
    FactoryGirl.create(:project,
                       :name => "The Xing Framework",
                       :description => "Cool new web framework!",
                      )
  end

  let! :project_2 do
    FactoryGirl.create(:project,
                       :name => "The Xing Book",
                       :description => "A book!",
                      )
  end

  let! :project_3 do
    FactoryGirl.create(:project,
                       :name => "The Xing Screencasts",
                       :description => "Screencasts!",
                      )
  end

  let :serializer do
    ProjectListSerializer.new([project_1, project_2, project_3])
  end

  describe "as_json" do
    let :json do serializer.to_json end

    it "should have the correct links" do
      expect(json).to be_json_string("/projects").at_path("links/self")
    end

    it "should have the correct structure and content" do
      expect(json).to be_json_string("/projects/#{project_1.id}").
                      at_path("data/0/links/self")
      expect(json).to be_json_string("The Xing Framework").
                      at_path("data/0/data/name")
      expect(json).not_to have_json_path("data/0/data/description")
      expect(json).not_to have_json_path("data/0/data/deadline")
      expect(json).not_to have_json_path("data/0/data/goal")
      expect(json).not_to have_json_path("data/0/data/user_id")

      expect(json).to be_json_string("/projects/#{project_2.id}").
                      at_path("data/1/links/self")
      expect(json).to be_json_string("The Xing Book").
                      at_path("data/1/data/name")
      expect(json).not_to have_json_path("data/1/data/description")
      expect(json).not_to have_json_path("data/1/data/deadline")
      expect(json).not_to have_json_path("data/1/data/goal")
      expect(json).not_to have_json_path("data/1/data/user_id")

      expect(json).to be_json_string("/projects/#{project_3.id}").
                      at_path("data/2/links/self")
      expect(json).to be_json_string("The Xing Screencasts").
                      at_path("data/2/data/name")
      expect(json).not_to have_json_path("data/2/data/description")
      expect(json).not_to have_json_path("data/2/data/deadline")
      expect(json).not_to have_json_path("data/2/data/goal")
      expect(json).not_to have_json_path("data/2/data/user_id")

      # the project descriptions do not appear anywhere in this resource
      expect(json).not_to be_json_string("Cool new web framework!")
      expect(json).not_to be_json_string("A Book!")
      expect(json).not_to be_json_string("Screencasts")
    end
  end
end
