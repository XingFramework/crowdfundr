class ProjectPledgesSerializer < Xing::Serializers::List
  def initialize(project)
    super(project.pledges)
    @project = project
  end

  def links
    {
      self: routes.project_pledges_path(@project),
      project: routes.project_path(@project)
    }
  end

  def item_serializer_class
    PledgeSerializer
  end
end
