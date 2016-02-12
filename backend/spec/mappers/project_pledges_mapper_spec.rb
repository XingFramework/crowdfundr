require 'spec_helper'

describe ProjectPledgesMapper, :type => :mappers do
  let :mapper do
    ProjectPledgesMapper.new(json, project.id)
  end

  let :project do
    FactoryGirl.create(:project)
  end

  let :valid_data do
    {
      links: {
        self: "/projects/#{project.id}/pledges",
        project: "/projects/#{project.id}"
      },
      data: [
        {
          links: {
            project: "/projects/#{project.id}",
            user: '',
            self: ''
          },
          data: {
            amount: '200',
            comment: 'I love this project'
          }
        }
      ]
    }
  end

  context 'valid data' do
    let :json do
      valid_data.to_json
    end

    it 'should create a new pledge in the list' do
      expect do
        mapper.save
      end.to change { project.pledges.reload.count }.by(1)
    end
  end

  context 'invalid data' do
    let :invalid_data do
      valid_data.deep_merge(
        {
          data: [
            {
              links: {
                project: '',
                user: '',
                self: ''
              },
              data: {
                amount: '200',
                comment: 'I love this project'
              }
            }
          ]
        }
      )
    end

    let :json do
      invalid_data.to_json
    end

    it "should not create a new pledge" do
      expect do
        mapper.save
      end.to_not change{ Pledge.count }
    end

    it "should add errors to the errors hash" do
      mapper.save
      expect(mapper.errors).to eq(
        {
          :data => {
            :pledges => {
              0 => {
                :project => {
                  :type => "required",
                  :message=>"can't be blank"
                }
              }
            }
          }
        }
      )
    end
  end
end
