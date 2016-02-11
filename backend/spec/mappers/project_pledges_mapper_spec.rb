require 'spec_helper'

describe ProjectPledgesMapper, :type => :mappers do
  let :project do
    FactoryGirl.create(:project)
  end

  context 'valid data' do
    it 'should create a new pledge in the list' do
      expect do
        mapper.save
      end.to change { project.pledges.reload.count }.by(1)
    end
  end
end
