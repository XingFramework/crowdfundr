require "spec_helper"

describe PledgeSerializer, :type => :serializer do
  let :serializer do
    PledgeSerializer.new(pledge)
  end

  let! :pledge do
    FactoryGirl.create(:pledge)
  end

  describe "as_json" do
    let :json do
      serializer.to_json
    end

    it "should have the correct structure" do
      expect(json).to have_json_path("links/self")
      expect(json).to have_json_path("links/project")
      expect(json).to have_json_path("links/user")

      expect(json).to have_json_path("data/amount")
      expect(json).to have_json_path("data/comment")
    end
  end

  describe "links" do
    it "should return pledge_path as self link" do
      expect(serializer.links[:self]).to include("pledges")
    end

    it "should return project_path as beat link" do
      expect(serializer.links[:project]).to include("projects")
    end
  end
end

