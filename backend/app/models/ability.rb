class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      user.role.set_abilities(self)

      # add common abilies to logged_in users
      can :create, Project
      can :manage, Project, user_id: user.id
    else
      # add common abilities to public users here
      can :read, Project
    end
  end
end
