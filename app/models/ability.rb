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
      can :read, Document, :namespace => :owner
    when 'manager'
    when 'council'
      can :read, Document, :namespace => :owner
      can :read, [Person, Suite, Locker]
    when 'admin'
      can :manage, :all
    end

    # FAKE NAMESPACE SUPPORT

    # Since cancancan doesn't have namespaced controller support, do it here crappily
    def can(action, subject, *extra_args)
      namespace = extract_namespace(extra_args)

      return if namespace && !Array.wrap(namespace).include?(@controller_namespace)

      super
    end

    def can?(action, subject, *extra_args)
      namespace = extract_namespace(extra_args)

      # Switch namespaces if we're asking about permisions from a different namespace
      if namespace && namespace != @controller_namespace
        Ability.new(@user, "#{namespace}::fakecontroller").can?(action, subject, *extra_args)
      else
        super
      end
    end

    def extract_namespace(extra_args)
      options = extra_args.extract_options!
      namespace = options.delete(:namespace)
      extra_args << options
      return namespace.to_sym if namespace
    end
  end
end
