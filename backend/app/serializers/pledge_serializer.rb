class PledgeSerializer < Xing::Serializers::Base
  attributes :amount, :comment

  def links
    {
      self: routes.pledge_path(object),
      project:  routes.project_path(object.project),
      user: user_link
    }
  end

  def user_link
    if object.user
      routes.user_path(object.user)
    end
  end
end
