require 'spec_helper'

describe 'GET /projects/:id', :type => :request do
  let! :project do
    FactoryGirl.create(:project,
                       :name => "The Xing Framework",
                       :description => "Cool new web framework!"
                      )
  end

  let! :resource_url do
    "/projects/#{project.id}"
  end

  it 'returned JSON is correctly formatted' do
    # fetch the resource using Xing's json_get helper
    json_get resource_url

    # Response should have a 2XX HTTP code
    expect(response).to be_success


    body = response.body

    # check that the self link, name, and description appear at the proper locations
    # within the returned JSON
    expect(body).to be_json_string(resource_url).at_path('links/self')
    expect(body).to be_json_string(project.name).at_path('data/name')
    expect(body).to be_json_string(project.description).at_path('data/description')
  end
end
