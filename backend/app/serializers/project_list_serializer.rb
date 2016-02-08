class ProjectListSerializer < Xing::Serializers::List

  def links
    {
      self:     routes.projects_path,
      template: routes.project_path_rfc6570
    }
  end

  def item_serializer_class
    ProjectSerializer
  end
end
