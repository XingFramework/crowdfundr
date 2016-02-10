class ProjectsController < ApplicationController

  # GET /projects
  def index
    projects =  projects = Project.all.order('created_at ASC')
    render :json => ProjectListSerializer.new(projects)
  end

  # GET /projects/{id}
  def show
    project = Project.find(params[:id])
    render :json => ProjectSerializer.new(project)
  end

  # POST /projects
  def create
    mapper = ProjectMapper.new(parse_json)

    if mapper.save
      successful_create(project_path(mapper.project))
    else
      failed_to_process(mapper.errors)
    end
  end

end
