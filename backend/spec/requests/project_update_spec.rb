require 'spec_helper'

describe "project#update", :type => :request do

  let! :project do FactoryGirl.create(:project,
                                      :name => "The Xing Framework",
                                      :description => "Pretty cool framework!",
                                      :deadline => Date.today + 30.days,
                                      :goal => 20000.00
                                     )
  end

  let :user do FactoryGirl.create(:user) end

  let :valid_data do
    {
      data: {
        name: "Xing Rules",
        description: "Awesome framework!",
        deadline: project.deadline,
        goal: project.goal
      }
    }
  end

  let :resource_url do
    "/projects/#{project.id}"
  end

  describe "Successful update" do
    describe 'PUT projects/#{project.id}' do
      let :json do valid_data.to_json end

      it "is a 200 success including the serialized object" do

        json_put resource_url, json

        expect(response).to be_success

        body = response.body

        expect(body).to have_json_path("links")
        expect(body).to have_json_path("links/self")
        expect(body).to have_json_path("data")
        expect(body).to have_json_path("data/name")
        expect(body).to have_json_path("data/description")
        expect(body).to have_json_path("data/deadline")
        expect(body).to have_json_path("data/goal")
      end

      it "should update information" do
        expect do
          json_put resource_url, json
        end.to change { project.reload.name }.to("Xing Rules")
      end
    end
  end
end


