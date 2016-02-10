require 'spec_helper'

describe 'pledges#create', :type => :request do

  describe 'as an anonymous user' do
    let :valid_data do
      {
        links: {
          project: '1',
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
end
