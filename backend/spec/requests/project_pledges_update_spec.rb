require 'spec_helper'

describe 'project_pledges#update', :type => :request do
  let :project do
    FactoryGirl.create(:project)
  end

  describe 'as an anonymous user' do
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

    let :json_body do
      data.to_json
    end

    describe 'PUT projects/:id/pledges' do
      describe 'successful update' do
        let :data do
          valid_data
        end

        it "should return 200 success and serialized object" do
          json_put "projects/#{project.id}/pledges", json_body
          expect(response.status).to eq(200)

          expect(response.body).to have_json_path("links/self")
          expect(response.body).to have_json_path("links/project")

          expect(response.body).to have_json_path("data/0/links/self")
          expect(response.body).to have_json_path("data/0/links/project")

          expect(response.body).to have_json_path("data/0/data/amount")
          expect(response.body).to have_json_path("data/0/data/comment")

          expect(response.body)
              .to be_json_string("/projects/#{project.id}/pledges").at_path("links/self")
          expect(response.body)
              .to be_json_string("/projects/#{project.id}").at_path("links/project")
        end

        it "should add new pledge" do
          expect do
            json_put "projects/#{project.id}/pledges", json_body
          end.to change { project.pledges.reload.count }.by(1)
        end
      end

      describe 'failing update' do
        let :data do
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

        it "returns 422" do
          json_post "project/#{project.id}/pledges", json_body
          expect(response.status).to eq(422)
          expect(response.body).to eq("{\"data\":{\"0\":{\"links\":{\"project\":{\"type\":\"required\",\"message\":\"can't be blank\"}}}}}")
        end
      end
    end
  end

  # TODO: Create specs for logged-in users
end
