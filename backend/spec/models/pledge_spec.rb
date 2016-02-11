require 'spec_helper'

describe Pledge, :type => :model do
  it "should have valid factories" do
    pledge = FactoryGirl.build(:pledge)
    expect(pledge).to be_valid
  end

  it "should require a project" do
    pledge_without_project = FactoryGirl.build(:pledge, project: nil)
    expect(pledge_without_project).to_not be_valid
  end

  it "should have all the proper columns" do
    expect(subject.attributes).to include('amount')
    expect(subject.attributes).to include('comment')
  end

  it "should belong to a project and user" do
    p = Pledge.reflect_on_association(:project)
    u = Pledge.reflect_on_association(:user)
    expect(p.macro).to eq(:belongs_to)
    expect(u.macro).to eq(:belongs_to)
  end
end
