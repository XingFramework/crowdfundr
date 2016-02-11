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

  #PUT /projects/{id}
  def update
    project = Project.find(params[:id])
    mapper = ProjectMapper.new(json_body, project.id)

    if mapper.save
      render :json => ProjectSerializer.new(mapper.project)
    else
      failed_to_process(mapper.errors)
    end
  end

  # POST /projects
  def create
    mapper = ProjectMapper.new(json_body)
    mapper.perform_mapping
    authorize! :create, mapper.project

    if mapper.save
      successful_create(project_path(mapper.project))
    else
      failed_to_process(mapper.errors)
    end
  end

end
