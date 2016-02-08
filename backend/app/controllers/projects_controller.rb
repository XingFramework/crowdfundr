class ProjectsController < ApplicationController

  # GET /projects/{id}
  def show
    project = Project.find(params[:id])
    render :json => ProjectSerializer.new(project)
  end

end
