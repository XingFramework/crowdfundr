require "spec_helper"

describe ProjectPledgesSerializer, :type => :serializer do
  let :serializer do
    ProjectPledgesSerializer.new(project)
  end

  let :project do
    FactoryGirl.create(:project_with_pledges, :pledges_count => 3)
  end

  describe "as_json" do
    let :json do serializer.to_json end

    it "should have the correct structure and scene" do
      expect(json).to be_json_string("/projects/#{project.id}/pledges").at_path("links/self")
      expect(json).to be_json_string("/projects/#{project.id}").at_path("links/project")

      expect(json).to be_json_string("/pledges/#{project.pledges[0].id}").at_path("data/0/links/self")
      expect(json).to be_json_string("/pledges/#{project.pledges[1].id}").at_path("data/1/links/self")
      expect(json).to be_json_string("/pledges/#{project.pledges[2].id}").at_path("data/2/links/self")
    end
  end
end
