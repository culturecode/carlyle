class Ability
  include CanCan::Ability

  def initialize(user, controller_name)
    @controller_namespace = controller_name.deconstantize.underscore.to_sym
    @user = user

    # BASELINE
    can [:home, :gallery, :floorplans, :contact], :pages

    return if user.blank?

    case user.role
    when 'owner'
      can :read, Document, :namespace => [:owner]
    when 'manager'
      can :read, Document, :namespace => [:admin]
    when 'council'
      can :read, Document, :namespace => [:admin]
    when 'admin'
      can :manage, :all
    end

    # Since cancancan doesn't have namespaced controller support, do it here crappily
    def can(action, subject, *extra_args)
      options = extra_args.last.is_a?(Hash) ? extra_args.last.dup : {}

      return if options[:namespace] && !Array.wrap(options[:namespace]).include?(@controller_namespace)

      super
    end

    def can?(action, subject, *extra_args)
      options = extra_args.last.is_a?(Hash) ? extra_args.last.dup : {}
      namespace = options.delete(:namespace)

      if namespace
        Ability.new(@user, "#{namespace}::fakecontroller").can?(action, subject, options)
      else
        super
      end
    end
  end
end
