require "spec_helper"

describe PledgeMapper, :type => :mapper do

  let :mapper do
    PledgeMapper.new(json)
  end

  let :project do
    FactoryGirl.create(:project)
  end

  let :user do
    FactoryGirl.create(:user)
  end

  let :valid_pledge do
    {
      links: {
        self: "",
        project: "/projects/#{project.id}",
        user: "/users/#{user.id}"
      },
      data: {}
    }
  end

  describe "saving content" do
    describe "valid data" do
      let :json do
        valid_pledge.to_json
      end

      it "should save the pledge" do
        expect { mapper.save }.to change{ Pledge.count }.by(1)
      end

      it "should return as truthy" do
        expect(mapper.save).to be_truthy
      end

      it "should be able to return pledge" do
        mapper.save
        expect(mapper.pledge).to be_a(Pledge)
        expect(mapper.pledge).to be_persisted
      end

      it "should associate the beat if given" do
        mapper.save
        expect(mapper.pledge.user).to eq(user)
      end
    end

    describe "invalid data" do
      let :invalid_pledge do
        valid_pledge.deep_merge(
          {
            links: {
              project: ""
            }
          }
        )
      end

      let :json do
        invalid_pledge.to_json
      end

      it "should not create a new beat" do
        expect do
          mapper.save
        end.to_not change{ Pledge.count }
      end

      it "should add errors to the errors hash" do
        mapper.save
        expect(mapper.errors).to eq(
          {
            :data => {
              :project => {
                :type => "required",
                :message => "can't be blank"
              }
            }
          }
        )
      end
    end
  end
end
