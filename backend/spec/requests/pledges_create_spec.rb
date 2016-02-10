require 'spec_helper'

describe 'pledges#create', :type => :request do
  let :project do
    FactoryGirl.create(:project)
  end

  describe 'as an anonymous user' do
    let :valid_data do
      {
        links: {
          project: "#{project.id}",
          user: '',
          self: ''
        },
        data: {
          amount: '200',
          comment: 'I love this project'
        }
      }
    end

    let :json_body do
      data.to_json
    end

    describe 'POST pledges' do
      describe 'successful create' do
        let :data do
          valid_data
        end

        it "returns 201" do
          json_post "pledges", json_body
          expect(response.status).to eq(201)
        end
      end

      describe 'failing create' do
        let :data do
          valid_data.deep_merge(
            {
              :links => {
                :project => ''
              }
            }
          )
        end

        it "returns 422" do
          json_post user "pledges", json_body
          expect(response.status).to eq(422)
          expect(response.body).to eq("{\"links\":{\"project\":{\"type\":\"required\",\"message\":\"can't be blank\"}}}")
        end
      end
    end
  end

  # TODO: Determine if a new route is needed for pledges
  # created by logged-in users
  #describe 'as a logged-in user' do
    #let :data do
      #valid_data.deep_merge(
        #{
          #:links => {
            #:user => "#{user.id}"
          #}
        #}
      #)
    #end

    #it "returns 201" do
      #authenticated_json_post user, "pledges", json_body
      #expect(response.status).to eq(201)
    #end
  #end
end
