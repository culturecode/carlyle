class Ability
  include CanCan::Ability

  def initialize(user)
    # BASELINE
    can [:home, :gallery, :floorplans, :contact], :pages

    return if user.blank?

    case user.role
    when 'owner'
      can :read, Document
    when 'manager'
      can :read, Document
    when 'council'
      can :read, Document
    when 'admin'
      can :manage, :all
    end
  end
end
