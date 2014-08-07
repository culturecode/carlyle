# Abstract Class
class CrierObserver < ActiveRecord::Observer
  class_attribute :current_user

  def cry(subject, action, object = nil)
    current_user.cry([subject, action, object].compact.join(' '), :subject => subject, :action => action, :object => object) if current_user
  end
end
