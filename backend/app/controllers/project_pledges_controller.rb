class ProjectPledgesController < ApplicationController
  def show
    project = Project.find(params[:project_id])
    render :json => ProjectPledgesSerializer.new(project)
  end

  def update
    mapper = ProjectPledgesMapper.new(json_body, params[:project_id].to_i)

    if mapper.save
      render :json => ProjectPledgesSerializer.new(mapper.project)
    else
      failed_to_process(mapper.errors)
    end
  end
end

