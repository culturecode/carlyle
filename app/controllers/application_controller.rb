class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  check_authorization :unless => :devise_controller?

  # devise_invitable - Only admins can send invitations
  def authenticate_inviter!
    can?(:invite, :users) ? current_user : raise(CanCan::AccessDenied)
  end

  rescue_from CanCan::AccessDenied, :with => :allow_user_login

  before_action :set_observer_current_user

  # Since cancan insists on loading a resource in order to grant access to the page,
  # skip the action only if the user is allowed to access the page. This allows us to
  # control access from the ability file without resorting to manually adding skip_authorize_resource
  def self.controller_loads_no_resource
    skip_authorization_check :if => proc {|c| c.can?(params[:action].to_sym, params[:controller].to_sym) }
  end

  # Allow the user a chance to log in, but re-raise the exception if they are already logged in
  def allow_user_login(exception, login_path = new_user_session_path)
    if user_signed_in?
      raise exception
    else
      store_location_for(:user, request.url)
      redirect_to login_path
    end
  end

  # Allow the user a chance to log in to the generic owner account, but re-raise the exception if they are already logged in
  def allow_owner_login(exception)
    allow_user_login(exception, new_owner_session_path)
  end

  private

  def current_ability
    Ability.new(current_user, self.class.name)
  end

  def set_observer_current_user
    CrierObserver.current_user = current_user
  end
end
