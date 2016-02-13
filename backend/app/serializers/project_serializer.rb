class ProjectSerializer < Xing::Serializers::Base
  attributes :name, :description, :deadline, :goal, :pledges

  def goal
    sprintf("%.2f", object.goal)
  end

  def pledges
    ProjectPledgesSerializer.new(object).as_json
  end

  def links
    {
      self: routes.project_path(object)
    }
  end
end
