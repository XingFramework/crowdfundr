class ProjectPledgesController < ApplicationController
  def update
    mapper = ProjectPledgesMapper.new(json_body, params[:project_id].to_i)

    if mapper.save
      render :json => ProjectPledgesSerializer.new(mapper.project)
    else
      failed_to_process(mapper.errors)
    end
  end
end

