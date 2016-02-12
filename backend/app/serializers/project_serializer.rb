class ProjectSerializer < Xing::Serializers::Base
  attributes :name, :description, :deadline, :goal, :user_id

  def goal
    sprintf("%.2f", object.goal)
  end

  def user_id
    object.user.id
  end

  def links
    {
      self: routes.project_path(object)
    }
  end
end
