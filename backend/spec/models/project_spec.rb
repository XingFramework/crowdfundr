require 'spec_helper'

describe Project, :type => :model do
  it "should have valid factories" do
    project = FactoryGirl.build(:project)
    project_with_pledges = FactoryGirl.build(:project_with_pledges)
    expect(project).to be_valid
    expect(project_with_pledges).to be_valid
  end

  it "should have all the proper columns" do
    expect(subject.attributes).to include('name')
    expect(subject.attributes).to include('description')
    expect(subject.attributes).to include('deadline')
    expect(subject.attributes).to include('goal')
  end

  it "should have many pledges" do
    p = Project.reflect_on_association(:pledges)
    expect(p.macro).to eq(:has_many)
    expect(subject).to respond_to(:pledges)
  end
end

