class ProjectSerializer < Xing::Serializers::Base
  attributes :name, :description, :deadline, :goal

  def goal
    sprintf("%.2f", object.goal)
  end

  def links
    {
      self: routes.project_path(object)
    }
  end
end
