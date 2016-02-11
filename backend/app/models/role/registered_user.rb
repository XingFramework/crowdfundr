class Role::RegisteredUser < Role
  Role.register 'RegisteredUser', self

  def set_abilities(ability)
    ability.can :read, Project
    ability.can :manage, Project, user_id: user.id
  end

end
