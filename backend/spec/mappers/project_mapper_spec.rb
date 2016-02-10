require 'spec_helper'

describe ProjectMapper, :type => :mapper do
  describe "saving content" do
    let :mapper do
      ProjectMapper.new(json)
    end

    let :valid_data do
      {
        links: {
          self: ""
        },
        data: {
          name: "Project One",
          description: "Great project.",
          deadline: 2016-03-11,
          goal: 20000.00
        }
      }
    end

    describe "valid data" do
      let :json do
        valid_data.to_json
      end

      it "should save the project" do
        expect do
          mapper.save
        end.to change{ Project.count }.by(1)
        expect(mapper.project.name).to eq("Project One")
        expect(mapper.project.description).to eq("Great project.")
      end

      it "should return as truthy" do
        expect(mapper.save).to be_truthy
      end

      it "should be able to return project" do
        mapper.save
        expect(mapper.project).to be_a(Project)
        expect(mapper.project).to be_persisted
      end
    end
  end
end
