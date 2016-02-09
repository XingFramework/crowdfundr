require 'spec_helper'

describe ProjectMapper, type: :mapper do

  let :time do
    Time.utc(2015, 3, 14, 9, 27)
  end

  let :valid_data do
    {
      links: {
        self: "",
        },
      data: {
        name: "User-Created Project",
        description: "This information was sent from the frontend",
        deadline: time,
        goal: 30000.00
        }
      }
  end

  describe "saving a new project" do
    let :json do
      valid_data.to_json
    end

    let :mapper do
      ProjectMapper.new(json)
    end

    it "saves the project" do
      expect do
        mapper.save
      end.to change{ Project.count }.by(1)
    end

    it "returns as truthy" do
      expect(mapper.save).to be_truthy
    end

    it "allows the mapper to return the saved project" do
      mapper.save
      expect(mapper.project).to be_a(Project)
      expect(mapper.project).to be_persisted
      expect(mapper.project.name).to eq("User-Created Project")
      puts(mapper.project)
    end
  end
end
