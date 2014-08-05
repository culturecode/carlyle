module Admin
  class NotificationsController < AdminController
    load_and_authorize_resource :class => Crier::Notification

    def index; end

    def show
      case @notification.subject
      when Document
        redirect_to [:owner, @notification.subject]
      when nil
        redirect_to :back, :notice => "The subject of this notification is no longer available"
      else
        redirect_to @notification.subject
      end
    end
  end
end
