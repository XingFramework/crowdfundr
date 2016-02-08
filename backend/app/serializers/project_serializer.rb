class ProjectSerializer < Xing::Serializers::Base
  attributes :name, :description, :deadline, :goal

  def links
    {
      self: routes.project_path(object)
    }
  end
end
