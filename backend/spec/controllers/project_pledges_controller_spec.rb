require 'spec_helper'

describe ProjectPledgesController do
  let :json do
    {
      stuff: "like this",
      more: "like that"
    }.to_json
  end

  let :mock_mapper do
    double(ProjectPledgesMapper)
  end

  let :project do
    double("project", :id => 1, :pledges => pledges)
  end

  let :pledges do
    double("array of pledges")
  end

  let :serializer do
    double(ProjectPledgesSerializer)
  end

  let :mock_errors do
    {
      data: {
        some_field: "Is required"
      }
    }
  end

  describe 'as an anonymous user' do
    describe "show" do
      it "should use the correct serializer and succeed" do
        allow(Project).to receive(:find).with("1").and_return(project)
        expect(ProjectPledgesSerializer).to receive(:new).with(project).and_return(serializer)
        expect(controller).to receive(:render).with(:json => serializer).and_call_original
        get :show, :project_id => project.id
        expect(response).to be_success
      end
    end

    describe 'update' do
      it "should update with scene mapper and pass the JSON to it" do
        expect(ProjectPledgesMapper).to receive(:new).with(json, 1).and_return(mock_mapper)
        expect(mock_mapper).to receive(:save).and_return(true)
        expect(mock_mapper).to receive(:project).and_return(project)
        expect(ProjectPledgesSerializer).to receive(:new).with(project).and_return(serializer)
        expect(controller).to receive(:render).with(:json => serializer).and_call_original
        put :update, json, { :project_id => 1 }
        expect(response).to be_success
      end

      it "should render status 422 if not updated" do
        expect(ProjectPledgesMapper).to receive(:new).with(json, 1).and_return(mock_mapper)
        expect(mock_mapper).to receive(:save).and_return(false)
        expect(mock_mapper).to receive(:errors).and_return(mock_errors)
        expect(controller).to receive(:failed_to_process).with(mock_errors).and_call_original
        put :update, json, { :project_id => 1 }
        expect(response).to reject_as_unprocessable
      end
    end
  end
end
