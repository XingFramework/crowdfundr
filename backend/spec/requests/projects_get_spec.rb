require 'spec_helper'

describe 'GET /projects', :type => :request do
  let! :project_1 do
    FactoryGirl.create(:project,
                       :name => "The Xing Framework",
                       :description => "Cool new web framework!"
                      )
  end

  let! :project_2 do
    FactoryGirl.create(:project,
                       :name => "The Xing Book",
                       :description => "A book about our new framework"
                      )
  end

  let! :project_3 do
    FactoryGirl.create(:project,
                       :name => "The Xing Screencasts",
                       :description => "Screencasts about our new framework"
                      )
  end


  let! :resource_url do
    "/projects"
  end

  it 'returned JSON has the correct contents and format' do
    # fetch the resource using Xing's json_get helper
    json_get resource_url

    # Response should have a 2XX HTTP code
    expect(response).to be_success


    body = response.body

    # check that the self link, name, and description appear at the proper locations
    # within the returned JSON
    expect(body).to be_json_string(resource_url).at_path('links/self')

    expect(body).to be_json_string(project_1.name).at_path('data/0/data/name')
    expect(body).to be_json_string(project_2.name).at_path('data/1/data/name')
    expect(body).to be_json_string(project_3.name).at_path('data/2/data/name')

    expect(body).not_to include(project_1.description)
    expect(body).not_to include(project_2.description)
    expect(body).not_to include(project_3.description)
  end
end
