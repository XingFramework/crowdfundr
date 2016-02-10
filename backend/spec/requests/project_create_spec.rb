require "spec_helper"

describe "POST /projects", type: :request do
  let :user do
    FactoryGirl.create(:user)
  end

  let :valid_data do
    {
      links: {
        self: ""
      },
      data: {
        name: "User-Created Project",
        description: "This information was sent from the frontend",
        deadline: Time.now + 3.days,
        goal: 30000.00,
        user_id: user.id,
      }
    }
  end

  let :json_body do
    data.to_json
  end

  context "on a successful create" do
    let :data do
      valid_data
    end

    it "returns 201 with the new address in the header 'Location'" do
      json_post "projects/", json_body
      expect(response.status).to eq(201)
      expect(response.headers["Location"]).
        to eq(project_path(Project.find_by(name: "User-Created Project")))
    end
  end

end
